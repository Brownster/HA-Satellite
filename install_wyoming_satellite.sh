############# INSTALL WYOMING ######################
echo "clone the wyoming-satellite repository"

git clone https://github.com/rhasspy/wyoming-satellite.git

echo "Install drivers for ReSpeaker 2Mic or 4Mic HAT if applicable"
cd wyoming-satellite/
sudo bash etc/install-repeaker-drivers.sh

echo "Install Wyoming Satellite"
cd wyoming-satellite/
python3 -m venv .venv
source .venv/bin/activate
pip3 install --upgrade pip
pip3 install --upgrade wheel setuptools
pip3 install -f 'https://synesthesiam.github.io/prebuilt-apps/' -r requirements.txt -r requirements_extra.txt

echo "Check if the installation was successful"
if [ -f script/run ]; then
  echo "Installation completed successfully."
  echo "You can now run the satellite with: ./script/run --help"
else
  echo "Installation failed. Please check for errors."
fi

echo "Function to record audio from a specific microphone device"
record_audio() {
  local device="$1"
  echo "Recording audio from device: plughw:$device..."
  arecord -D "plughw:$device" -r 16000 -c 1 -f S16_LE -t wav -d 5 test.wav
}

echo "Function to play back recorded audio"
play_audio() {
  local device="$1"
  echo "Playing back recorded audio on device: plughw:$device..."
  aplay -D "plughw:$device" test.wav
}

echo "Listing available microphones:"
arecord -l

# Prompt user to choose a microphone device
echo "Enter the card number and device number of the microphone you want to use format of card_number,device_number:"
read chosen_microphone

# Record and play audio with the chosen microphone device
record_audio "$chosen_microphone"
play_audio "$chosen_microphone"

# Check if there were problems during recording
if [ $? -ne 0 ]; then
  echo "Error occurred during recording. Trying a different microphone device..."

  # List available microphones again
  echo "Listing available microphones:"
  arecord -l

  # Prompt user to choose a different microphone device
  echo "Enter a different microphone device with format of card_number,device_number:"
  read new_microphone

# Use the new microphone device for recording and playback
if [ -n "$new_microphone" ]; then
  record_audio "$new_microphone"
  play_audio "$new_microphone"
else
  echo "Using default microphone device."
  record_audio "$chosen_microphone" # Using the originally chosen device
  play_audio "$chosen_microphone"   # Using the originally chosen device for playback
fi

# Run the satellite
echo "Starting the Wyoming Satellite..."
./script/run \
  --debug \
  --name 'my satellite' \
  --uri 'tcp://0.0.0.0:10700' \
  --mic-command "arecord -D plughw:$chosen_microphone -r 16000 -c 1 -f S16_LE -t raw" \
  --snd-command "aplay -D plughw:$chosen_microphone -r 22050 -c 1 -f S16_LE -t raw" &


# Create a systemd service for the satellite
sudo tee /etc/systemd/system/wyoming-satellite.service > /dev/null <<EOL
[Unit]
Description=Wyoming Satellite
Wants=network-online.target
After=network-online.target

[Service]
Type=simple
ExecStart=$PWD/script/run --name 'my satellite' --uri 'tcp://0.0.0.0:10700' --mic-command 'arecord -D plughw:$chosen_microphone-r 16000 -c 1 -f S16_LE -t raw' --snd-command 'aplay -D plughw:$chosen_microphone-r 22050 -c 1 -f S16_LE -t raw'
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


