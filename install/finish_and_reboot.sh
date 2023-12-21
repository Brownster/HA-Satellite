#!/bin/bash

echo "A bit of clean up"
sudo apt autoremove -y

# Reboot the satellite
echo "rebooting the server"
sudo reboot
