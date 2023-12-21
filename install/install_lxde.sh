#!/bin/bash

echo "Installing LXDE and setting up auto-login..."

# Install Xorg and LXDE
sudo apt-get install --no-install-recommends xserver-xorg -y
sudo apt-get install lxde-core lxappearance -y

# Optional: Install LightDM (if you want a display manager / login screen)
#sudo apt-get install lightdm

# Enable SSH (Optional, if you want remote access)
sudo raspi-config nonint do_ssh 0

# Ask for the username
read -p "Enter the username for auto-login: " username

# Check if the user exists
if id "$username" &>/dev/null; then
    echo "Configuring auto-login for $username..."

    # Create a service file for getty@tty1
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
    echo "[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $username --noclear %I $TERM" | sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf

    # Add auto-start of X to user's .bash_profile
    echo "if [ -z \"\$DISPLAY\" ] && [ \"\$(tty)\" = \"/dev/tty1\" ]; then
  startx
fi" | sudo tee -a /home/$username/.bash_profile

    # Create or modify the .xinitrc file in user's home directory
    echo "#!/bin/sh
exec startlxde
/usr/src/chromium/start-chromium.sh" | sudo tee /home/$username/.xinitrc

    sudo chown $username:$username /home/$username/.xinitrc
    sudo chmod +x /home/$username/.xinitrc

    echo "Auto-login and auto-start of LXDE configured for $username."
else
    echo "User $username does not exist. Please create this user and rerun the script."
fi

echo "Setting next boot to GUI"
sudo systemctl set-default graphical.target

echo "LXDE installation and configuration complete."
