#!/bin/bash
################## Install scripts for MQTT etc and make them services.#######################
source "$(dirname "$0")/config.sh"
cd $INSTALL_DIR
if [ ! -d "HA-Satellite" ]; then
    sudo git clone https://github.com/Brownster/HA-Satellite
fi
cd $INSTALL_PATH/scripts

# Create the '$USER_GROUP' group and user for running the scripts
echo "Creating group and user '$USER_GROUP' for running the scripts..."
if ! id "$USER_GROUP" &>/dev/null; then
    echo "Creating group and user '$USER_GROUP' for running the scripts..."
    sudo groupadd -f $USER_GROUP
    sudo useradd -r -M -g $USER_GROUP -s /bin/false $USER
else
    echo "User '$USER' already exists. Skipping user creation."
fi

# Create systemd services for Python scripts with 'hasatellite' user and group
create_service() {
    script_name="$1"
    service_name="${script_name%.py}"  # Remove the .py extension to create the service name
    service_file="/etc/systemd/system/${service_name}.service"
    venv_path="$VENV_DIR"  # Path to the virtual environment's Python interpreter

    echo "Creating systemd service for $script_name..."
    cat <<EOF | sudo tee "$service_file" > /dev/null
[Unit]
Description=My Python Script: $script_name
After=network.target
Wants=network.target

[Service]
ExecStart=$venv_path "$PWD/$script_name"
Restart=always
User=$USER
Group=$USER_GROUP
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
python_scripts=("mqtt-listener.py" "spotify-alarm.py" "kiosk-home.py")

# Create systemd services for each script
for script in "${python_scripts[@]}"; do
    create_service "$script"
done
