#!/bin/bash
################## Install scripts for MQTT etc and make them services.#######################

cd /usr/src
sudo git clone https://github.com/Brownster/HA-Satellite
cd /usr/src/HA-Satellite/scripts

# Create the 'hasatellite' group and user for running the scripts
echo "Creating group and user 'hasatellite' for running the scripts..."
sudo groupadd -f hasatellite
sudo useradd -r -M -g hasatellite -s /bin/false hasatellite

# Create systemd services for Python scripts with 'hasatellite' user and group
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
User=hasatellite
Group=hasatellite
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
