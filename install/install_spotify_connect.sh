#!/bin/bash
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

#  Configure raspotify
#echo "Step 4: Configuring raspotify"
#echo "You can customize your Raspotify settings by editing the configuration file."
#echo "To edit the configuration file, run the following command:"
#echo "sudo nano /etc/raspotify/conf"
#echo "Inside the configuration file, you can modify settings such as the device name and bitrate."
#echo "Remember to save your changes CTRL + X, Y, ENTER and restart the raspotify service after making any modifications."

# Restart the raspotify service
echo "Step 5: Restarting the raspotify service..."
sudo systemctl restart raspotify

echo "Raspotify setup completed. You can now connect to your Raspberry Pi via Spotify Connect."
