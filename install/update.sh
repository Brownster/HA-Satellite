#!/bin/bash

# Update and upgrade the system
echo "Updating and upgrading the system..."

sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt clean

echo "Installing necessary packages..."
# Removed subprocess from the installation list
sudo apt install --no-install-recommends git python3-venv python3 python3-pip python3-paho-mqtt python3-playsound apache2 onboard -y