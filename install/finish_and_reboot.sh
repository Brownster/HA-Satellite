#!/bin/bash
source "$(dirname "$0")/config.sh"
echo "A bit of clean up"
sudo apt autoremove -y

# Remove the line containing SCRIPT_RESTART from .bashrc
sed -i '/SCRIPT_RESTART/d' ~/.bashrc

# Reload .bashrc in the current session
source ~/.bashrc

echo "SCRIPT_RESTART variable removed from .bashrc and reloaded in the current session."

# Reboot the satellite
echo "rebooting the server in 5 seconds..."
pause 5
sudo reboot
