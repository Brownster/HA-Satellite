#!/bin/bash
#Install LXDE
echo "Installing LXDE..."

# Install Xorg and LXDE
sudo apt-get install --no-install-recommends xserver-xorg -y
sudo apt-get install lxde-core lxappearance -y

# Optional: Install LightDM (if you want a display manager / login screen)
#sudo apt-get install lightdm

# Enable SSH (Optional, if you want remote access)
sudo raspi-config nonint do_ssh 0
