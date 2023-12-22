#!/bin/bash
######## INSTALL SPOTIFY CONNECT ################
#  Install required packages
echo "Installing required packages..."
sudo apt install -y apt-transport-https curl

#  Add GPG key and repository for raspotify
echo "Adding GPG key and repository for raspotify..."
curl -sSL https://dtcooper.github.io/raspotify/key.asc | sudo tee /usr/share/keyrings/raspotify-archive-keyrings.asc >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/raspotify-archive-keyrings.asc] https://dtcooper.github.io/raspotify raspotify main' | sudo tee /etc/apt/sources.list.d/raspotify.list

#  Install raspotify package
echo "Installing raspotify package..."
sudo apt update
sudo apt install -y raspotify

#  Configure raspotify
#echo "Step 4: Configuring raspotify"
#echo "You can customize your Raspotify settings by editing the configuration file."
#echo "To edit the configuration file, run the following command:"
#echo "sudo nano /etc/raspotify/conf"
#echo "Inside the configuration file, you can modify settings such as the device name and bitrate."
#echo "Remember to save your changes CTRL + X, Y, ENTER and restart the raspotify service after making any modifications."

# Script to set a USB DAC as the default audio device on Raspberry Pi

echo "Listing all available audio devices..."
device_list=$(aplay -l | grep '^card')

# Check if no devices were found
if [ -z "$device_list" ]; then
    echo "No audio devices found. Please ensure your audio device is connected."
    exit 1
fi

echo "$device_list"
echo

# Create an array to store device card numbers
declare -a card_numbers
index=0

# Extract card numbers and populate the array
while read -r line; do
    card_number=$(echo $line | awk '{print $2}' | tr -d :)
    card_numbers[$index]=$card_number
    let index++
done <<< "$device_list"

# Display options to the user
echo "Select the output device:"
for i in "${!card_numbers[@]}"; do
    echo "[$i] Card number: ${card_numbers[$i]}"
done

# Ask the user to choose a device
read -p "Enter your choice (0-${#card_numbers[@]}): " choice

# Validate user input
if ! [[ "$choice" =~ ^[0-9]+$ ]] || [ "$choice" -ge "${#card_numbers[@]}" ]; then
    echo "Invalid selection. Exiting."
    exit 1
fi

selected_card=${card_numbers[$choice]}

# Backup the original alsa.conf file
sudo cp /usr/share/alsa/alsa.conf /usr/share/alsa/alsa.conf.backup

# Update the alsa.conf file with the selected card number
sudo sed -i "s/defaults.ctl.card 0/defaults.ctl.card $selected_card/" /usr/share/alsa/alsa.conf
sudo sed -i "s/defaults.pcm.card 0/defaults.pcm.card $selected_card/" /usr/share/alsa/alsa.conf

echo "The default audio device is set to card number $selected_card."


# Restart the raspotify service
echo "Restarting the raspotify service..."
sudo systemctl restart raspotify

echo "Raspotify setup completed. You can now connect to your Raspberry Pi via Spotify Connect."
