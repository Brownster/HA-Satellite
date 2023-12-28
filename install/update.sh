#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."

sudo apt update
sudo apt upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get clean

echo "Installing necessary packages..."
# Removed subprocess from the installation list
sudo apt install --no-install-recommends git python3-venv python3 python3-pip apache2 onboard -y

echo "Installing Python packages..."
pip3 install paho-mqtt playsound 
