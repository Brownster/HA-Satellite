# HA-Satellite
The aim is a home assistant satellite with voice intergration and dashboard also spotify connect and alarm clock all with some kind of control via mqtt.


INSTALL SCRIPT
install raspberry pi 64 bit minimal, set up wifi ssh etc in imager application
plugin your usb mic / speakers / hats etc
login to raspberry pi and run the following

command 1:   
sudo wget https://raw.githubusercontent.com/Brownster/HA-Satellite/main/install.sh && sudo bash install.sh && cd /usr/src/HA-Satellite/install && sudo bash main.sh


You should be greeted with:

Installation script for multiple components. Please select an option:
0. Install updates and dependencies
1. Install LXDE
2. Install Chromium in Kiosk Mode
3. Install Wyoming Satellite
4. Install Spotify Connect
5. Setup Services
6. Setup Python HTTP Server
7. Clean up and reboot
8. Install all components
9. Exit
Enter your choice (0-9):


Here's a summary of what this script does:
    It give you the options to perform
    updates and upgrades the system.
    Install Chromium in kiosk mode.
    Create a script to launch Chromium in kiosk mode.
    Optionally, it sets up debugging for Chromium.
    Add Chromium to autostart.
    Clone the Wyoming Satellite repository.
    Install drivers and dependencies for Wyoming Satellite.
    Prompt the user to choose a microphone device for recording audio.
    Record and plays back audio to test the chosen microphone device.
    Runs the Wyoming Satellite with appropriate parameters.
    Create a systemd service for Wyoming Satellite.
    Install and configures Raspotify for Spotify Connect.
    Prompt the user for my_script_user and my_script_group.
    Create systemd services for Python scripts with user and group values.
    Reboot the server.
