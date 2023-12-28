#!/bin/bash
source "$(dirname "$0")/config.sh"
############# INSTALL WYOMING ######################
# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Function to install a package
install_package() {
    local package=$1

    # Detect the package manager
    if command_exists apt-get; then
        # Debian/Ubuntu
        sudo apt-get update
        sudo apt-get install -y "$package"
    elif command_exists yum; then
        # CentOS/RHEL
        sudo yum install -y "$package"
    elif command_exists brew; then
        # macOS (Homebrew)
        brew install "$package"
    else
        echo "Package manager not found. You must manually install $package."
        return 1
    fi

    return 0
}

# Check for git and install if not present
if ! command_exists git; then
    echo "git is not installed. Attempting to install git..."
    if ! install_package git; then
        echo "Failed to install git. Exiting."
        exit 1
    fi
fi

# Check for python3 and install if not present
if ! command_exists python3; then
    echo "Python 3 is not installed. Attempting to install Python 3..."
    if ! install_package python3; then
        echo "Failed to install Python 3. Exiting."
        exit 1
    fi
fi

echo "clone the wyoming-satellite repository"
# Get the FQDN of the current machine
fqdn=$(hostname -f)
cd $INSTALL_DIR
git clone https://github.com/rhasspy/wyoming-satellite.git

echo "Install drivers for ReSpeaker 2Mic or 4Mic HAT if applicable"
mkdir -p $INSTALL_DIR/respeaker
cd $INSTALL_DIR/respeaker/
git clone https://github.com/respeaker/seeed-voicecard
cd seeed-voicecard
sudo bash ./install.sh
cd $INSTALL_DIR/wyoming-satellite
echo "Install Wyoming Satellite"
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

# Function to validate the microphone input
validate_microphone_input() {
    local input=$1
    if [[ $input =~ ^[0-9]+,[0-9]+$ ]]; then
        local card_number=$(echo $input | cut -d',' -f1)
        local device_number=$(echo $input | cut -d',' -f2)
        if arecord -l | grep -q "card $card_number:.*device $device_number"; then
            return 0 # Valid input
        else
            echo "Invalid microphone: Card $card_number Device $device_number not found."
            return 1 # Invalid input
        fi
    else
        echo "Invalid format. Please enter in the format of card_number,device_number."
        return 1 # Invalid format
    fi
}

# Loop until valid input is received
chosen_microphone=""
while [ -z "$chosen_microphone" ]; do
    echo "Enter the card number and device number of the microphone you want to use in the format of card_number,device_number:"
    read input_microphone
    if validate_microphone_input "$input_microphone"; then
        chosen_microphone="$input_microphone"
        record_audio "$chosen_microphone"
        if [ $? -ne 0 ]; then
            echo "Error occurred during recording. Please try a different microphone device..."
            chosen_microphone=""
        else
            chosen_speaker="$chosen_microphone"
            play_audio "$chosen_speaker"
        fi
    fi
done

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
  play_audio "$chosen_speaker"   # Using the originally chosen device for playback
fi

# Run the satellite
echo "Starting the Wyoming Satellite..."
./script/run \
  --debug \
  --name '$fqdn' \
  --uri 'tcp://0.0.0.0:10700' \
  --mic-command "arecord -D plughw:$chosen_microphone -r 16000 -c 1 -f S16_LE -t raw" \
  --snd-command "aplay -D plughw:$chosen_speaker -r 22050 -c 1 -f S16_LE -t raw" &


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