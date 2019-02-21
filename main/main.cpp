#undef CONFIG_ARDUHAL_ESP_LOG
#include <Arduino.h>
#include <BLEDevice.h>
//#include <BLEUtils.h>
#include <BLEScan.h>
#include <BLEAdvertisedDevice.h>
#include <BLEServer.h>
#include "esp_bt_main.h"
#include "esp_bt_device.h"

#define SERVICE_UUID        "4fafc201-1fb5-459e-8fcc-c5c9c331914b"
#define CHARACTERISTIC_UUID "beb5483e-36e1-4688-b7f5-ea07361b26a8"

// wifi connection variables
const char* ssid = "NETGEAR31";
const char* password = "fluffywind547";

#include <WiFi.h>
#include <WiFiUdp.h>


WiFiUDP Udp;

IPAddress rIP = IPAddress(192,168,1,13); // remote ip
int port = 33333; // the destination port



int scanTime = 5; //In seconds
BLEScan* pBLEScan;
void scanNow(){
  String data = "";
  data += WiFi.macAddress() + ",";

  Serial.println("scan start");
  // WiFi.scanNetworks will return the number of networks found
  int n = WiFi.scanNetworks();
  Serial.println("scan done");
  if (n == 0)
    Serial.println("no networks found");
  else
  {
    Serial.print(n);
    Serial.println(" networks found");
    for (int i = 0; i < n; ++i)
    {
      // Print SSID and RSSI for each network found
      Serial.print(i + 1);
      Serial.print(": ");
      Serial.print(WiFi.SSID(i));
      Serial.print(" (");
      Serial.print(WiFi.RSSI(i));
      Serial.println(")");
     // Serial.println((WiFi.encryptionType(i) == ENC_TYPE_NONE)?" ":"*");

     data += WiFi.BSSIDstr(i) + "__" + WiFi.RSSI(i) + ",";
     // delay(10);
    }
    
  } 
 
  // BLE Scan
  static BLEAddress x = BLEDevice::getAddress();
  data += "\n";
  data += String(x.toString().c_str()) + ",";
  BLEScanResults foundDevices = pBLEScan->start(scanTime, false);
  for (uint32_t i = 0; i < foundDevices.getCount(); i++)
  {
    BLEAdvertisedDevice device = foundDevices.getDevice(i);
    Serial.println(device.getRSSI());
    Serial.println(device.getName().c_str());
    data += String(device.getAddress().toString().c_str()) + "__" + String(device.getRSSI()) + ",";
  }
  Serial.println("Scan done!");
  pBLEScan->clearResults();   // delete results fromBLEScan buffer to release memory
  delay(20);


    Serial.println(data);

    Udp.beginPacket(rIP, port);
    Udp.write((uint8_t *)data.c_str(),data.length());
    Udp.endPacket();
  Serial.println("");

  // Wait a bit before scanning again
  delay(100);
}
class MyAdvertisedDeviceCallbacks: public BLEAdvertisedDeviceCallbacks {
    void onResult(BLEAdvertisedDevice advertisedDevice) {
      if(advertisedDevice.getName() == "TG")
      Serial.printf("%i : %s \n", advertisedDevice.getRSSI(), advertisedDevice.toString().c_str());
      //Serial.printf("0 %i -100\n", advertisedDevice.getRSSI());
    }
};


void setupAsEmitter()
{
  BLEDevice::init("Long name works now");
  BLEServer *pServer = BLEDevice::createServer();
  BLEService *pService = pServer->createService(SERVICE_UUID);
  BLECharacteristic *pCharacteristic = pService->createCharacteristic(
                                         CHARACTERISTIC_UUID,
                                         BLECharacteristic::PROPERTY_READ |
                                         BLECharacteristic::PROPERTY_WRITE
                                       );

  pCharacteristic->setValue("");
  pService->start();
  // BLEAdvertising *pAdvertising = pServer->getAdvertising();  // this still is working for backward compatibility
  BLEAdvertising *pAdvertising = BLEDevice::getAdvertising();
  pAdvertising->addServiceUUID(SERVICE_UUID);
  pAdvertising->setScanResponse(true);
  pAdvertising->setMinPreferred(0x06);  // functions that help with iPhone connections issue
  pAdvertising->setMinPreferred(0x12);
  BLEDevice::startAdvertising();
  Serial.println("Characteristic defined! Now you can read it in your phone!");
}

void setup() {
  Serial.begin(115200);
 // Serial.println("Scanning...");
 

      // We start by connecting to a WiFi network

    Serial.println();
    Serial.println();
    Serial.print("Connecting to ");
    Serial.println(ssid);

    WiFi.begin(ssid, password);

    while (WiFi.status() != WL_CONNECTED) {
        delay(500);
        Serial.print(".");
    }

    Serial.println("");
    Serial.println("WiFi connected");
    Serial.println("IP address: ");
    Serial.println(WiFi.localIP());

  BLEDevice::init("");

  pBLEScan = BLEDevice::getScan(); //create new scan
  pBLEScan->setAdvertisedDeviceCallbacks(new MyAdvertisedDeviceCallbacks());
  pBLEScan->setActiveScan(true); //active scan uses more power, but get results faster
  pBLEScan->setInterval(100);
  pBLEScan->setWindow(99);  // less or equal setInterval value
  setupAsEmitter();


}



void loop() {
    scanNow();

}





