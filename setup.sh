sudo apt-get install gcc git wget make libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-cryptography python-future python-pyparsing

export PATH="~/esp32-cc/xtensa-esp32-elf/bin:$PATH"
export IDF_PATH="~/esp32-cc/esp-idf"


python -m pip install --user -r $IDF_PATH/requirements.txt


#run make
