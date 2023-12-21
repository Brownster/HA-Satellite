#!/bin/bash
echo "Setting next boot to gui"
sudo systemctl set-default graphical.target

echo "A bit of clean up"
sudo apt autoremove -y

# Reboot the satellite
echo "rebooting the server"
sudo reboot
