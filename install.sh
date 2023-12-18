#    Download Raspbian Minimal from the official Raspberry Pi website.
#    Flash the Raspbian Minimal image onto an SD card using a tool like Etcher.
#    Insert the SD card into your Raspberry Pi and power it on.

#Step 2: Install Required Software
#Connect to your Raspberry Pi via SSH or use the terminal directly.
#Update the package list and upgrade installed packages:

sudo apt update
sudo apt upgrade

#Step 3: Install Chromium
#Install Chromium:

sudo apt install chromium-browser

#Step 4: Set up Kiosk Mode
#Create a new script to launch Chromium in kiosk mode:

nano /home/pi/start-chromium.sh

#Add the following content to the script and save it:

#!/bin/bash
chromium-browser --kiosk http://homeassistant.local:8123

#Make the script executable:

chmod +x /home/pi/start-chromium.sh

#Step 5: Set up Debug Mode
#To enable debugging, you can modify the script to run Chromium with remote debugging enabled:

#!/bin/bash
chromium-browser --kiosk --remote-debugging-port=9222 http://homeassistant.local:8123

#Step 6: Autostart Chromium
#To make Chromium start automatically when the Raspberry Pi boots up, you can add the script to the LXDE autostart file:

#nano /etc/xdg/lxsession/LXDE-pi/autostart

#Add the following line to the end of the file:

#@/home/pi/start-chromium.sh
