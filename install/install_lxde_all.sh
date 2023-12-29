#!/bin/bash
source "$(dirname "$0")/config.sh"

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
echo "if you want to change the auto-login user, choose option 'p' and select 'System Options' > 'Boot / Auto Login'"

# Append the export command to .bashrc
echo 'export SCRIPT_RESTART="true"' >> ~/.bashrc

# Reload .bashrc in the current session
source ~/.bashrc

echo "SCRIPT_RESTART variable added to .bashrc and reloaded in the current session."
echo "To continue the installation, run the following command:"
echo "sudo bash start.sh"
echo "from your home directory."
echo "The system will reboot in 5 seconds..."
pause 5
sudo reboot now
