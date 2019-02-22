sudo apt update

sudo apt-get install gcc git wget make libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-cryptography python-future python-pyparsing


echo export PATH="/home/ubuntu/esp32-cc/xtensa-esp32-elf/bin:$PATH" > ~/.bash_profile
echo export IDF_PATH="/home/ubuntu/esp32-cc/esp-idf"  >> ~/.bash_profile
source ~/.bash_profile

git clone --recursive https://github.com/espressif/esp-idf.git


python -m pip install --user -r $IDF_PATH/requirements.txt


# make.sh
