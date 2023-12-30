#!/bin/bash
source "$(dirname "$0")/config.sh"

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update
sudo apt upgrade -y
sudo apt dist-upgrade -y
sudo apt clean

echo "Installing necessary packages..."
# Install necessary packages with apt
sudo apt install --no-install-recommends git python3-venv python3 python3-pip apache2 onboard -y

# Check if the virtual environment directory exists
if [ ! -d "$VENV_DIR" ]; then
    echo "Creating a Python virtual environment..."
    python3 -m venv "$VENV_DIR"
else
    echo "Python virtual environment already exists."
fi

# Activate the virtual environment
source "$VENV_DIR/bin/activate"

# Upgrade pip, wheel, and setuptools in the virtual environment
echo "Upgrading pip, wheel, and setuptools..."
pip install --upgrade pip wheel setuptools paho-mqtt playsound RPi.GPIO

# Deactivate the virtual environment
deactivate

echo "System and Python packages update complete."
