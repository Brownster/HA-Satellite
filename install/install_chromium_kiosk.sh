#!/bin/bash
source "$(dirname "$0")/config.sh"
################ INSTALL CHROMIUM IN KIOSK MODE #######################
# This script will install Chromium and configure it to run in kiosk mode

echo "Installing Chromium..."

# Install Chromium
sudo apt install chromium-browser -y

# Create the directory for the Chromium start script
sudo mkdir -p $INSTALL_DIR/chromium

sudo touch $INSTALL_DIR/chromium/start-chromium.sh

# Create a script to launch Chromium in kiosk mode
sudo cat <<EOF > $INSTALL_DIR/chromium/start-chromium.sh
#!/bin/bash
USER_AGENT="Mozilla/5.0 (Linux; Android 8.0; Pixel C Build/OPR1.170623.032) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36"
chromium-browser --kiosk --user-agent="\$USER_AGENT" --remote-debugging-port=9222 http://127.0.0.1:8000
EOF

# Make the Chromium start script executable
sudo chmod +x $INSTALL_DIR/chromium/start-chromium.sh

echo "Chromium installation and autostart configuration complete."

# Ask for the username
read -p "Enter your username: " username

# Define the source and destination paths
src="/etc/xdg/lxsession/LXDE/autostart"
dest="/home/$username/.config/lxsession/LXDE/autostart"

# Create the directory if it doesn't exist
mkdir -p "$(dirname "$dest")"

# Copy the autostart file
cp "$src" "$dest"

# Add the Chromium start command to the autostart file
echo "@chromium-browser --noerrors --disable-session-crashed-bubble --disable-infobars --start-fullscreen https://127.0.0.1" >> "$dest"
#echo "@chromium-browser --noerrors --kiosk --disable-session-crashed-bubble --disable-infobars --start-fullscreen https://127.0.0.1" >> "$dest"
#echo "@chromium --noerrors --disable-session-crashed-bubble --disable-infobars --start-fullscreen https://127.0.0.1" >> "$dest"
#echo "@/usr/src/chromium/start-chromium.sh" >> "$dest"
echo "Autostart file has been configured."
