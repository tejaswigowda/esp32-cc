sudo apt update

sudo apt-get install gcc git wget make libncurses-dev flex bison gperf python python-pip python-setuptools python-serial python-cryptography python-future python-pyparsing

git clone --recursive https://github.com/espressif/esp-idf.git


python -m pip install --user -r $IDF_PATH/requirements.txt


# make.sh
