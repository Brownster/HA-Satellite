HA-Satellite
Overview

HA-Satellite aims to create a multifunctional Home Assistant satellite with various features including voice integration, a dashboard, Spotify Connect, and an alarm clock, all controllable via MQTT. This project is a work-in-progress.
Target Platform

    OS: Pi OS Debian Bookworm Minimal 64bit
    Device: Raspberry Pi 4 (4GB RAM)
    Testing Setup: USB headset for Wyoming and separate speaker for Spotify Connect. Ensure all USB devices are connected before powering on the Pi.

Installation
Prerequisites

    Install Raspberry Pi 64-bit minimal OS. Configure Wi-Fi, SSH, etc., using the Raspberry Pi Imager application. Raspberry Pi Getting Started Guide
    Connect USB mic, speakers, HATs, etc. Current testing is with a USB headset; plans may include a USB conference mic and a simple USB speaker for the assistant, and an audio DAC HAT for Spotify.

Steps

    Login to Raspberry Pi and execute the following command:
  
    sudo wget https://raw.githubusercontent.com/Brownster/HA-Satellite/main/install.sh && sudo bash install.sh && cd /usr/src/HA-Satellite/install && sudo bash main.sh


Follow the Installation Script Prompts:



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

Script Functions

    Updates and upgrades the system.
    Installs Chromium in kiosk mode (WIP).
    Adds Chromium to autostart (WIP).
    Clones the Wyoming Satellite repository.
    Installs drivers and dependencies for Wyoming Satellite.
    Prompts for microphone device selection.
    Tests the chosen microphone device with recording and playback.
    Runs Wyoming Satellite with appropriate parameters.
    Creates a systemd service for Wyoming Satellite.
    Installs and configures Raspotify for Spotify Connect.
    Creates a user and group for running scripts.
    Sets up systemd services for Python scripts with user/group.
    Reboots the server.
