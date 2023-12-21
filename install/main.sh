#!/bin/bash

# Main installation script
echo "Installation script for multiple components. Please select an option:"
echo "0. Intsall updates and despendancies"
echo "1. Install LXDE"
echo "2. Install Chromium in Kiosk Mode"
echo "3. Install Wyoming Satellite"
echo "4. Install Spotify Connect"
echo "5. Setup Services"
echo "6. Setup Python HTTP Server"
echo "7. Clean up and reboot"
echo "8. Install all components"
echo "Enter your choice (0-8): "
read choice

case $choice in
  0) bash update.sh;;
  1) bash install_lxde.sh;;
  2) bash install_chromium_kiosk.sh;;
  3) bash install_wyoming_satellite.sh;;
  4) bash install_spotify_connect.sh;;
  5) bash setup_services.sh;;
  6) bash setup_python_http_server.sh;;
  7) bash finish_and_reboot.sh;;
  8) bash update.sh
     bash install_lxde.sh
     bash install_chromium_kiosk.sh
     bash install_wyoming_satellite.sh
     bash install_spotify_connect.sh
     bash setup_services.sh
     bash setup_python_http_server.sh
     bash finish_and_reboot.sh
     echo "All components have been installed.";;
  *) echo "Invalid option. Please enter a number between 0 and 8.";;
esac
