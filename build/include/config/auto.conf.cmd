deps_config := \
	/home/ubuntu/esp32-cc/esp-idf/components/app_trace/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/aws_iot/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/bt/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/driver/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/esp32/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/esp_adc_cal/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/esp_event/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/esp_http_client/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/esp_http_server/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/esp_https_ota/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/espcoredump/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/ethernet/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/fatfs/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/freemodbus/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/freertos/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/heap/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/libsodium/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/log/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/lwip/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/mbedtls/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/mdns/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/mqtt/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/nvs_flash/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/openssl/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/pthread/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/spi_flash/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/spiffs/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/tcpip_adapter/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/unity/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/vfs/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/wear_levelling/Kconfig \
	/home/ubuntu/esp32-cc/esp-idf/components/app_update/Kconfig.projbuild \
	/home/ubuntu/esp32-cc/components/arduino-esp32/Kconfig.projbuild \
	/home/ubuntu/esp32-cc/esp-idf/components/bootloader/Kconfig.projbuild \
	/home/ubuntu/esp32-cc/esp-idf/components/esptool_py/Kconfig.projbuild \
	/home/ubuntu/esp32-cc/main/Kconfig.projbuild \
	/home/ubuntu/esp32-cc/esp-idf/components/partition_table/Kconfig.projbuild \
	/home/ubuntu/esp32-cc/esp-idf/Kconfig

include/config/auto.conf: \
	$(deps_config)

ifneq "$(IDF_TARGET)" "esp32"
include/config/auto.conf: FORCE
endif
ifneq "$(IDF_CMAKE)" "n"
include/config/auto.conf: FORCE
endif

$(deps_config): ;
