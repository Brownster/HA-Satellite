#!/bin/bash
################ INSTALL CHROMIUM IN KIOSK MODE #######################
# Install Chromium
echo "Installing Chromium..."
sudo apt install chromium-browser -y

# Create the directory for the Chromium start script
echo "Creating directory for Chromium start script..."
sudo mkdir -p /usr/src/chromium

# Create a script to launch Chromium in kiosk mode with mobile user agent
echo "Setting up script to start Chromium in kiosk mode"
cat <<EOF > /usr/src/chromium/start-chromium.sh
#!/bin/bash
# Example user agent of a tablet device
USER_AGENT="Mozilla/5.0 (Linux; Android 8.0; Pixel C Build/OPR1.170623.032) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36"
chromium-browser --kiosk --user-agent="$USER_AGENT" --remote-debugging-port=9222 http://127.0.0.1:8000
EOF

# Make the Chromium start script executable
sudo chmod +x /usr/src/chromium/start-chromium.sh

# Auto Start Chromium in Kiosk Mode
echo "Setting up Chromium to start in kiosk mode on boot..."

# Ensure the autostart directory exists
mkdir -p ~/.config/lxsession/LXDE-pi/

# Write the commands to the autostart file
echo "@lxpanel --profile LXDE-pi" > ~/.config/lxsession/LXDE-pi/autostart
echo "@pcmanfm --desktop --profile LXDE-pi" >> ~/.config/lxsession/LXDE-pi/autostart
echo "@/usr/src/chromium/start-chromium.sh" >> ~/.config/lxsession/LXDE-pi/autostart
echo "@florence -d" >> ~/.config/lxsession/LXDE-pi/autostart
