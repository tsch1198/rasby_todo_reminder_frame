#!/bin/bash
# install_pi.sh

echo "Installing base dependencies"
sudo apt-get update
sudo apt-get install -y python-pip \
    python3-pip python3-pil python3-numpy wiringpi \
    libopenjp2-7 libjpeg-dev zlib1g-dev libatlas-base-dev

cd ../

echo "Installing python dependencies";
sudo apt install python3-virtualenv

python3 -m virtualenv -p python3 env
. env/bin/activate
pip install --upgrade pip setuptools wheel
pip install -r src/requirements.txt


echo "Installing epaper dependencies";
wget http://www.airspayce.com/mikem/bcm2835/bcm2835-1.60.tar.gz
tar zxvf bcm2835-1.60.tar.gz 
cd bcm2835-1.60/
sudo ./configure
sudo make
sudo make check
sudo make install

wget https://github.com/WiringPi/WiringPi/releases/download/3.10/wiringpi_3.10_arm64.deb
sudo dpkg -i wiringpi_3.10_arm64.deb
gpio -v

echo "Cleaning up";
sudo rm -rf bcm2835-1.60.tar.gz
sudo rm -rf bcm2835-1.60

echo "Setup complete";
