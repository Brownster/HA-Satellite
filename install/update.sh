#!/bin/bash
echo "this script attemts to install chromium in kiosk mode HA satellite for voice, spotify connect"
echo "an alarm clock and simple gui. With mqtt as to have some level of control over the assistants hardware"
#                                                                                                      
#                  ___ ___                          _______             __       __               __   
#                 |   Y   .-----.--------.-----.   |   _   .-----.-----|__.-----|  |_.---.-.-----|  |_ 
#                 |.  1   |  _  |        |  -__|   |.  1   |__ --|__ --|  |__ --|   _|  _  |     |   _|
#                 |.  _   |_____|__|__|__|_____|   |.  _   |_____|_____|__|_____|____|___._|__|__|____|
#                 |:  |   |                        |:  |   |                                           
#                 |::.|:. |                        |::.|:. |                                           
#                 `--- ---'                        `--- ---'                                           
#                        ___ ___       __                _______       __         __ __ __ __          
#                       |   Y   .-----|__.----.-----.   |   _   .---.-|  |_.-----|  |  |__|  |_.-----. 
#                       |.  |   |  _  |  |  __|  -__|   |   1___|  _  |   _|  -__|  |  |  |   _|  -__| 
#                       |.  |   |_____|__|____|_____|   |____   |___._|____|_____|__|__|__|____|_____| 
#                       |:  1   |                       |:  1   |                                      
#                        \:.. ./                        |::.. . |                                      
#                         `---'                         `-------'                                      
#                                                                                                      


# Update and upgrade the system
echo "Updating and upgrading the system..."

sudo apt update
sudo apt upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get clean

echo "Installing necessary packages..."
sudo apt-get install --no-install-recommends git python3-venv python3 python3-pip apache2 onboard -y

echo "Installing Python packages..."
pip3 install paho-mqtt playsound
