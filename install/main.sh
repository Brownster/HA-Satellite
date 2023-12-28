#!/bin/bash
echo "this script is no where near complete but none the less attempts to install chromium in kiosk mode HA satellite for voice,"
echo "spotify connect, an alarm clock with very simple gui to set times leveraging crontab. With mqtt as to have some level of control over the assistants hardware"
#
echo "                                                                                                       "
echo "                  ___ ___                          _______             __       __               __   "
echo "                 |   Y   .-----.--------.-----.   |   _   .-----.-----|__.-----|  |_.---.-.-----|  |_ "
echo "                 |.  1   |  _  |        |  -__|   |.  1   |__ --|__ --|  |__ --|   _|  _  |     |   _|"
echo "                 |.  _   |_____|__|__|__|_____|   |.  _   |_____|_____|__|_____|____|___._|__|__|____|"
echo "                 |:  |   |                        |:  |   |                                           "
echo "                 |::.|:. |                        |::.|:. |                                           "
echo "                 \___|___/                        \___|___/                                         "
echo "                        ___ ___       __                _______       __         __ __ __ __          "
echo "                       |   Y   .-----|__.----.-----.   |   _   .---.-|  |_.-----|  |  |__|  |_.-----. "
echo "                       |.  |   |  _  |  |  __|  -__|   |   1___|  _  |   _|  -__|  |  |  |   _|  -__| "
echo "                       |.  |   |_____|__|____|_____|   |____   |___._|____|_____|__|__|__|____|_____| "
echo "                       |:  1   |                       |:  1   |                                      "
echo "                        \:.. ./                        |::.. . |                                      "
echo "                          ---                           -------'                                      "
echo "                                                                                                     "
source "$(dirname "$0")/config.sh"




# Function to display the menu
show_menu() {
    echo "                                                                                  "
    echo "                                                                                  "
    echo "Installation script for Home Assistant HUB. If this is the first run, please run  "
    echo "option c and s first making sure to set the correct settings for your environment."
    echo "then run option 8 to install all components. Or run each option individually.  "
    echo "                                                                                  "                                                                                                    
    echo "Please select an option:"
    echo "                                                                                  "
    echo "0. Install updates and dependencies"
    echo "1. Install LXDE"
    echo "2. Install Chromium in Kiosk Mode"
    echo "3. Install Wyoming Satellite"
    echo "4. Install Spotify Connect"
    echo "5. Setup Services"
    echo "6. Setup Hub Homepage"
    echo "7. Clean up and reboot"
    echo "8. Install all components"
    echo "9. Exit"
    echo "######### OPTIONS #########"
    echo "a. Run the Home Assistant mqtt discovery python script"
    echo "c. Edit Installer Configuration File"
    echo "d. Install Drivers (SEEED VOICE HAT)"
    echo "p. Run raspi-config to set desktop autologin and other settings"
    echo "s. Edit Python Scripts settings file"
    echo "Enter your choice (0-9 or a,c,d,p,s): "
}

# Main installation script
while true; do
    show_menu
    read choice

    case $choice in
      0) bash update.sh;;
      1) bash install_lxde.sh;;
      2) bash install_chromium_kiosk.sh;;
      3) bash install_wyoming_satellite.sh;;
      4) bash install_spotify_connect.sh;;
      5) bash setup_services.sh;;
      6) bash setup_homepage_http_server.sh;;
      7) bash finish_and_reboot.sh;;
      8) bash update.sh
         bash install_lxde.sh
         bash install_chromium_kiosk.sh
         bash install_wyoming_satellite.sh
         bash install_spotify_connect.sh
         bash setup_services.sh
         bash setup_homepage_http_server.sh
         bash finish_and_reboot.sh
         echo "All components have been installed.";;
      9) echo "Exiting script."
         break;;
      a) sudo python3 $INSTALL_PATH/scripts/mqtt_adiscovery.py;;  
      c) sudo nano $INSTALL_CONFIG_FILE;;
      d) bash seeed-voice-hat.sh;;
      p) sudo sudo raspi-config;;
      s) sudo nano $PYTHON_SCRIPTS_CONFIG_FILE;;
      *) echo "Invalid option. Please enter a number between 0 and 9 or a Letter a,c,d,p,s).";;
    esac
done