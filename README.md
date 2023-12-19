# HA-Satellite
The aim is a home assistant satellite with voice intergration and dashboard also spotify connect and alarm clock


INSTALL SCRIPT
includes prompts to ask the user for my_script_user and my_script_group values. These values will be used when creating systemd services for the Python scripts later in the script.

Here's a summary of what this script does:

    It updates and upgrades the system.
    Installs Chromium in kiosk mode.
    Creates a script to launch Chromium in kiosk mode.
    Optionally, it sets up debugging for Chromium.
    Adds Chromium to autostart.
    Clones the Wyoming Satellite repository.
    Installs drivers and dependencies for Wyoming Satellite.
    Prompts the user to choose a microphone device for recording audio.
    Records and plays back audio to test the chosen microphone device.
    Runs the Wyoming Satellite with appropriate parameters.
    Creates a systemd service for Wyoming Satellite.
    Installs and configures Raspotify for Spotify Connect.
    Prompts the user for my_script_user and my_script_group.
    Creates systemd services for Python scripts with user and group values.
    Reboots the server.
