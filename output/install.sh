
python /home/ubuntu/esp32-cc/esp-idf/components/esptool_py/esptool/esptool.py --chip esp32 --port /dev/cu.SLAB_USBtoUART --baud 921600 --before default_reset --after hard_reset write_flash -z --flash_mode dio --flash_freq 80m --flash_size detect 0xe000 ./ota_data_initial.bin 0x1000 ./bootloader.bin 0x10000 ./test.bin 0x8000 ./default.bin




