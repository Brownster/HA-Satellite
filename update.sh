#!/bin/bash
# Update and upgrade the system
echo "Step 1: Updating and upgrading the system..."
sudo apt update
sudo apt upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get clean
sudo apt-get install --no-install-recommends git python3-venv florence pygame git apache2
pip install paho-mqtt playsound
