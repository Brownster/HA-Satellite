#!/bin/bash
echo "this script attemts to install chromium in kiosk mode HA satellite for voice and spotify connect."
echo"⠀⠀⠀⠀⠀⠀⠀⠀⢀⣠⠤⢤⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⠀⢀⠎⠀⠀⠀⠘⣦⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⢠⣾⡖⢦⣰⣿⢲⠸⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⢨⠻⢷⣟⠙⠿⠞⠀⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⢸⠦⠤⠷⠶⠶⠂⠀⢸⠀⠀⠀⠀⠀⠀⢀⢀⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⡆⡄⢸⠀⠀⠀⠀⠀⢠⠃⢸⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⠀⡇⡇⢸⣇⡀⠀⠀⡠⠁⢠⠃⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⢸⠀⠀⠀⠀⣸⠃⢻⠈⠈⠉⢙⣳⣥⣄⣀⠔⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⠸⡆⠀⠀⠰⣧⣶⠌⠂⠀⠀⠉⠁⠀⠀⠉⠳⡄⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⠀⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⠀⠹⢦⣀⣀⣀⡀⠀⢀⣀⣀⡀⠀⢀⣀⡠⠚⠀⠀⠀⠀⠀⠀"⠀
echo"⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⠉⡹⠉⠉⠉⠉⢉⠇⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⠰⡉⠑⠁⢠⠃⠀⠀⣟⠓⠋⢠⠃⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
echo"⠀⠀⠀⠀⠀⠀⠀⠈⠛⠒⠁⠀⠀⠀⠈⠓⠒⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
# Update and upgrade the system
echo "Step 1: Updating and upgrading the system..."
sudo apt update
sudo apt upgrade -y
sudo apt-get install --no-install-recommends git python3-venv florence pygame

################ INSTALL CHROMIUM IN KIOSK MODE #######################
# Install Chromium
echo "Installing Chromium..."
sudo apt install chromium-browser -y

# Create a script to launch Chromium in kiosk mode
echo "Creating a script to launch Chromium in kiosk mode..."
cat <<EOF > /usr/src/chromium/start-chromium.sh
# #!/bin/bash
chromium-browser --kiosk --no-first-run http://127.0.0.1:8000 & florence
chmod +x /usr/src/chromium/start-chromium.sh

# Set up Debug Mode (Optional)
echo "Step 4: Setting up Debug Mode (Optional)..."
# To enable debugging, you can modify the script to run Chromium with remote debugging enabled:
# Uncomment the following lines if you want to enable debugging.
# cat <<EOF >> /usr/src/chromium/start-chromium.sh
# #!/bin/bash
# chromium-browser --kiosk --remote-debugging-port=9222 http://homeassistant.local:8123
# EOF

#  Autostart Chromium
echo "Step 5: Adding Chromium to autostart..."
# Add the script to the LXDE autostart file
echo "@/usr/src/chromium/start-chromium.sh" >> /etc/xdg/lxsession/LXDE-pi/autostart

############# INSTALL WYOMING ######################
#clone the wyoming-satellite repository
git clone https://github.com/rhasspy/wyoming-satellite.git

# Install drivers for ReSpeaker 2Mic or 4Mic HAT (if applicable)
cd wyoming-satellite/
sudo bash etc/install-repeaker-drivers.sh

# Install Wyoming Satellite
cd wyoming-satellite/
python3 -m venv .venv
source .venv/bin/activate
pip3 install --upgrade pip
pip3 install --upgrade wheel setuptools
pip3 install -f 'https://synesthesiam.github.io/prebuilt-apps/' -r requirements.txt -r requirements_extra.txt

# Check if the installation was successful
if [ -f script/run ]; then
  echo "Installation completed successfully."
  echo "You can now run the satellite with: ./script/run --help"
else
  echo "Installation failed. Please check for errors."
fi

# Function to record audio from a specific microphone device
record_audio() {
  local device="$1"
  echo "Recording audio from device: $device..."
  arecord -D "$device" -r 16000 -c 1 -f S16_LE -t wav -d 5 test.wav
}

# Function to play back recorded audio
play_audio() {
  local device="$1"
  echo "Playing back recorded audio on device: $device..."
  aplay -D "$device" test.wav
}

# List available microphones
echo "Listing available microphones:"
arecord -L

# Prompt user to choose a microphone device
echo "Enter the microphone device you want to use (e.g., plughw:CARD=seeed2micvoicec,DEV=0):"
read chosen_microphone

# Record and play audio with the chosen microphone device
record_audio "$chosen_microphone"

# Check if there were problems during recording
if [ $? -ne 0 ]; then
  echo "Error occurred during recording. Trying a different microphone device..."

  # List available microphones again
  echo "Listing available microphones:"
  arecord -L

  # Prompt user to choose a different microphone device
  echo "Enter a different microphone device (or press Enter to use default):"
  read new_microphone

  # Use the new microphone device for recording and playback
  if [ -n "$new_microphone" ]; then
    record_audio "$new_microphone"
  else
    echo "Using default microphone device."
    record_audio "$chosen_microphone" # Using the originally chosen device
  fi
fi

# Play back the recorded audio
play_audio "$chosen_microphone" # Using the originally chosen device for playback



# Run the satellite
echo "Starting the Wyoming Satellite..."
./script/run \
  --debug \
  --name 'my satellite' \
  --uri 'tcp://0.0.0.0:10700' \
  --mic-command 'arecord -D plughw:CARD=seeed2micvoicec,DEV=0 -r 16000 -c 1 -f S16_LE -t raw' \
  --snd-command 'aplay -D plughw:CARD=seeed2micvoicec,DEV=0 -r 22050 -c 1 -f S16_LE -t raw'

# Create a systemd service for the satellite
sudo tee /etc/systemd/system/wyoming-satellite.service > /dev/null <<EOL
[Unit]
Description=Wyoming Satellite
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=$PWD/script/run --name 'my satellite' --uri 'tcp://0.0.0.0:10700' --mic-command 'arecord -D plughw:CARD=seeed2micvoicec,DEV=0 -r 16000 -c 1 -f S16_LE -t raw' --snd-command 'aplay -D plughw:CARD=seeed2micvoicec,DEV=0 -r 22050 -c 1 -f S16_LE -t raw'
WorkingDirectory=$PWD
Restart=always
RestartSec=1

[Install]
WantedBy=default.target
EOL

# Enable and start the systemd service
sudo systemctl enable --now wyoming-satellite.service

echo "Wyoming Satellite service is now running."
echo "You can check the logs with: journalctl -u wyoming-satellite.service -f"



######## INSTALL SPOTIFY CONNECT ################
#  Install required packages
echo "Step 1: Installing required packages..."
sudo apt install -y apt-transport-https curl

#  Add GPG key and repository for raspotify
echo "Step 2: Adding GPG key and repository for raspotify..."
curl -sSL https://dtcooper.github.io/raspotify/key.asc | sudo tee /usr/share/keyrings/raspotify-archive-keyrings.asc >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/raspotify-archive-keyrings.asc] https://dtcooper.github.io/raspotify raspotify main' | sudo tee /etc/apt/sources.list.d/raspotify.list

#  Install raspotify package
echo "Step 3: Installing raspotify package..."
sudo apt update
sudo apt install -y raspotify

#  Configure raspotify (optional)
echo "Step 4: Configuring raspotify (optional)..."
echo "You can customize your Raspotify settings by editing the configuration file."
echo "To edit the configuration file, run the following command:"
echo "sudo nano /etc/raspotify/conf"
echo "Inside the configuration file, you can modify settings such as the device name and bitrate."
echo "Remember to save your changes (CTRL + X, Y, ENTER) and restart the raspotify service (Step 6) after making any modifications."

# Restart the raspotify service
echo "Step 5: Restarting the raspotify service..."
sudo systemctl restart raspotify

echo "Raspotify setup completed. You can now connect to your Raspberry Pi via Spotify Connect."



################## Install scripts for MQTT etc and make them services.#######################

cd /usr/src
wget https://github.com/Brownster/HA-Satellite
cd /usr/src/HA-Satellite/scripts

# Create and enable systemd services for Python scripts
# Prompt the user for my_script_user
echo "Enter the username for running the scripts:"
read my_script_user

# Prompt the user for my_script_group
echo "Enter the group name for running the scripts:"
read my_script_group

# Create systemd services for Python scripts with user and group values
create_service() {
    script_name="$1"
    service_name="${script_name%.py}"  # Remove the .py extension to create the service name
    service_file="/etc/systemd/system/${service_name}.service"

    echo "Creating systemd service for $script_name..."
    cat <<EOF | sudo tee "$service_file" > /dev/null
[Unit]
Description=My Python Script: $script_name
After=network.target
Wants=network.target

[Service]
ExecStart=/usr/bin/python3 "$PWD/$script_name"
Restart=always
User=$my_script_user
Group=$my_script_group
WorkingDirectory=$PWD
StandardOutput=journal

[Install]
WantedBy=multi-user.target
EOF

    sudo systemctl daemon-reload
    sudo systemctl enable "$service_name"
    sudo systemctl start "$service_name"
}

# List of Python scripts you want to create services for
python_scripts=("mqtt-listener.py" "alarm-clock.py" "kiosk-home.py")

# Create systemd services for each script
for script in "${python_scripts[@]}"; do
    create_service "$script"
done

######### Create a script to start a Python HTTP server and configure it as a systemd service #######

# Create the Python HTTP server script
echo "Creating Python HTTP server script..."
cat <<EOF > /usr/src/HA-Satellite/scripts/start_web_server.sh
#!/bin/bash
cd /usr/src/HA-Satellite/templates/main/
python3 -m http.server 8000
EOF

# Make the script executable
chmod +x /home/pi/start_web_server.sh

# Create a systemd service for the Python HTTP server
echo "Creating systemd service for the Python HTTP server..."
cat <<EOF > /etc/systemd/system/web-server.service
[Unit]
Description=Local Web Server
After=network.target

[Service]
ExecStart=/usr/src/HA-Satellite/scripts/start_web_server.sh
Restart=always
User=pi
Group=pi

[Install]
WantedBy=multi-user.target
EOF

# Enable the systemd service to start at boot
systemctl enable web-server.service

# Start the service
systemctl start web-server.service

echo "Web server setup completed."

# Reboot the satellite
echo " rebooting the server"
sudo reboot
