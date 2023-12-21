#!/bin/bash

echo "Installing LXDE..."

# Install Xorg and LXDE
sudo apt-get install --no-install-recommends xserver-xorg -y
sudo apt-get install lxde-core lxappearance -y

# Enable SSH (Optional, if you want remote access)
sudo raspi-config nonint do_ssh 0

# Set the Raspberry Pi to auto-login to the desktop as the 'pi' user
echo "Setting up auto-login to desktop as the 'pi' user..."
sudo raspi-config nonint do_boot_behaviour B4

echo "LXDE installation complete. The system will auto-login to desktop as the 'pi' user."
