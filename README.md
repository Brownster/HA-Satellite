HA-Satellite
Overview

HA-Satellite aims to create a multifunctional Home Assistant satellite with various features including voice integration, a dashboard, Spotify Connect, and an alarm clock, all controllable via MQTT. This project is a work-in-progress.

Target Platform:

    OS: Pi OS Debian Bookworm Minimal 64bit
    Device: Raspberry Pi 4 (4GB RAM)
    Testing Setup: USB headset for Wyoming and separate speaker for Spotify Connect. Ensure all USB devices are 
                   connected before powering on the Pi.

Installation
Prerequisites:

    Install Raspberry Pi 64-bit minimal OS. Configure Wi-Fi, SSH, etc., using the Raspberry Pi Imager application. 
    See Raspberry Pi Getting Started Guide https://www.raspberrypi.com/documentation/computers/getting-started.html
    Connect USB mic, speakers, HATs, etc. Current testing is with a USB headset; 
    plans may include a USB conference mic/speaker and an audio DAC HAT for Spotify for now I am trying the audio 
    jack with powered speakers for spotify and have a usb headset for wyoming. Touch screen is on order from Aliexpress.
        Touchscreen: http://tinyurl.com/seveninchscreen

Installation Steps:

Login to Raspberry Pi and execute the following command:
  
    sudo wget https://raw.githubusercontent.com/Brownster/HA-Satellite/main/install.sh && sudo bash install.sh && cd /usr/src/HA-Satellite/install && sudo bash main.sh


Follow the Installation Script Prompts:

You should see something like the below Menu, i suggest rebooting after install the desktop. you should have start.sh 
in your home directory so after a reboot run start.sh to get the main script running again. If you chose the install all option, 
choose that option again it should continue from where it left off after installing desktop.

    
    sudo bash start.sh

Please select an option:

    0. Install updates and dependencies
    1. Install LXDE
    2. Install Chromium in Kiosk Mode
    3. Install Wyoming Satellite
    4. Install Spotify Connect
    5. Setup Services
    6. Setup Hub Homepage
    7. Clean up and reboot
    8. Install all components
    9. Exit
    ######### OPTIONS #########
    a. Run the Home Assistant mqtt discovery python script
    c. Edit Installer Configuration File
    d. Install Drivers (SEEED VOICE HAT)
    p. Run raspi-config to set desktop autologin and other settings
    s. Edit Python Scripts settings file
    Enter your choice (0-9 or a,c,d,p,s):


Script Functions

    Updates and upgrades the system.
    Installs Chromium in kiosk mode.
    Adds Chromium to autostart.
    Clones the Wyoming Satellite repository.
    Installs drivers and dependencies for Wyoming Satellite.
    Prompts for microphone device selection.
    Tests the chosen microphone device with recording and playback.
    Runs Wyoming Satellite with appropriate parameters.
    Creates a systemd service for Wyoming Satellite.
    Installs and configures Raspotify for Spotify Connect.
    Creates a user and group for running scripts.
    Sets up systemd services for Python scripts with user/group. WIP
    Reboots the server.
