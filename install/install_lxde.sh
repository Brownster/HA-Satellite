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

echo "Setting next boot to gui"
sudo systemctl set-default graphical.target
#make sure its not running - comment out if you want lightdm
sudo systemctl disable lightdm

