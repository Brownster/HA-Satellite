#!/bin/bash
################ INSTALL CHROMIUM IN KIOSK MODE #######################
# This script will install Chromium and configure it to run in kiosk mode

echo "Installing Chromium..."

# Install Chromium
sudo apt install chromium-browser -y

# Create the directory for the Chromium start script
sudo mkdir -p /usr/src/chromium

# Create a script to launch Chromium in kiosk mode
cat <<EOF > /usr/src/chromium/start-chromium.sh
#!/bin/bash
USER_AGENT="Mozilla/5.0 (Linux; Android 8.0; Pixel C Build/OPR1.170623.032) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.198 Safari/537.36"
chromium-browser --kiosk --user-agent="\$USER_AGENT" --remote-debugging-port=9222 http://127.0.0.1:8000
EOF

# Make the Chromium start script executable
sudo chmod +x /usr/src/chromium/start-chromium.sh

cp /etc/xdg/lxsession/LXDE/autostart ~/.config/lxsession/LXDE/

# Add Chromium start script to system-wide LXDE autostart
echo "Adding Chromium start script to system-wide LXDE autostart..."
{
    echo "@/usr/src/chromium/start-chromium.sh"
} | sudo tee -a /etc/xdg/lxsession/LXDE/autostart

echo "Chromium installation and autostart configuration complete."
