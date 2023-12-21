#!/bin/bash

echo "Installing LXDE and setting up auto-login..."

# Install Xorg and LXDE
sudo apt-get install --no-install-recommends xserver-xorg -y
sudo apt-get install lxde-core lxappearance -y

# Enable SSH (Optional, if you want remote access)
sudo raspi-config nonint do_ssh 0

# Ask for the username
read -p "Enter the username for auto-login: " username

# Check if the user exists
if id "$username" &>/dev/null; then
    echo "Configuring auto-login for $username..."

    # Create a service file for getty@tty1 for auto-login
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d/
    echo "[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin $username --noclear %I $TERM" | sudo tee /etc/systemd/system/getty@tty1.service.d/autologin.conf

    # Ensure the autostart directory exists for the specified user
    sudo mkdir -p /home/$username/.config/lxsession/LXDE-pi/

    # Write the autostart configuration
    {
        echo "@lxpanel --profile LXDE-pi"
        echo "@pcmanfm --desktop --profile LXDE-pi"
        # Additional autostart commands can be added here
    } | sudo tee /home/$username/.config/lxsession/LXDE-pi/autostart

    echo "Auto-login and auto-start of LXDE configured for $username."
else
    echo "User $username does not exist. Please create this user and rerun the script."
fi

echo "Setting next boot to GUI"
sudo systemctl set-default graphical.target

echo "LXDE installation and configuration complete."
