#!/bin/bash

#!/bin/bash

# Update and upgrade the system
echo "Step 1: Updating and upgrading the system..."
sudo apt update
sudo apt upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get clean
sudo apt-get install --no-install-recommends git python3-venv florence pygame git apache2
pip install paho-mqtt playsound

# Main installation script
echo "Installation script for multiple components. Please select an option:"
echo "1. Install LXDE"
echo "2. Install Chromium in Kiosk Mode"
echo "3. Install Wyoming Satellite"
echo "4. Install Spotify Connect"
echo "5. Setup MQTT Services"
echo "6. Setup Python HTTP Server"
echo "7. Install All Components"
echo "Enter your choice (1-7): "
read choice

case $choice in
  1) sh install_lxde.sh;;
  2) sh install_chromium_kiosk.sh;;
  3) sh install_wyoming_satellite.sh;;
  4) sh install_spotify_connect.sh;;
  5) sh setup_mqtt_services.sh;;
  6) sh setup_python_http_server.sh;;
  7) sh install_lxde.sh
     sh install_chromium_kiosk.sh
     sh install_wyoming_satellite.sh
     sh install_spotify_connect.sh
     sh setup_mqtt_services.sh
     sh setup_python_http_server.sh
     echo "All components have been installed.";;
  *) echo "Invalid option. Please enter a number between 1 and 7.";;
esac
