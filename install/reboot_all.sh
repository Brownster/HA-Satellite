#!/bin/bash
source "$(dirname "$0")/config.sh"

# Append the export command to .bashrc
echo 'export SCRIPT_RESTART="true"' >> ~/.bashrc

# Reload .bashrc in the current session
source ~/.bashrc

echo "SCRIPT_RESTART variable added to .bashrc and reloaded in the current session."
echo "To continue the installation after reboot, run the following command:"
echo "sudo bash start.sh"
echo "from your home directory.(the place where you land after login)"
echo "The system will reboot in 10 seconds..."
pause 10
sudo reboot now
