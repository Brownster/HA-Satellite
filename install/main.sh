#!/bin/bash

# Main installation script
echo "Installation script for multiple components. Please select an option:"
echo "0. Intsall updates and despendancies"
echo "1. Install LXDE"
echo "2. Install Chromium in Kiosk Mode"
echo "3. Install Wyoming Satellite"
echo "4. Install Spotify Connect"
echo "5. Setup MQTT Services"
echo "6. Setup Python HTTP Server"
echo "7. Clean up and reboot"
echo "8. Install all components"
echo "Enter your choice (0-8): "
read choice

case $choice in
  0) sh update.sh;;
  1) sh install_lxde.sh;;
  2) sh install_chromium_kiosk.sh;;
  3) sh install_wyoming_satellite.sh;;
  4) sh install_spotify_connect.sh;;
  5) sh setup_mqtt_services.sh;;
  6) sh setup_python_http_server.sh;;
  7) sh finish_and_reboot.sh;;
  8) sh update.sh
     sh install_lxde.sh
     sh install_chromium_kiosk.sh
     sh install_wyoming_satellite.sh
     sh install_spotify_connect.sh
     sh setup_services.sh
     sh setup_python_http_server.sh
     sh finish_and_reboot.sh
     echo "All components have been installed.";;
  *) echo "Invalid option. Please enter a number between 0 and 8.";;
esac
