#!/bin/bash
#tbh not sure if this is needed, all we need is a webserver to serve the html files
#and Apache2 looks to be installed so just a case of copying files over 
#it to serve the HA Satellite web pages at http://localhost/index.html

sudo mkdir -p /var/www/html/static/
sudo rm -rf /var/www/html/index.html
sudo cp /usr/src/HA-Satellite/scripts/static/main-static/* /var/www/html/static
sudo cp /usr/src/HA-Satellite/scripts/templates/home-index.html /var/www/html/index.html

# ######### Create a script to start a Python HTTP server and configure it as a systemd service #######
# sudo cp /usr/src/HA-Satellite/templates/home-index.html /var/www/html/ha-home/index.html
# echo "Copying images to web server directory..."
# sudo cp /usr/src/HA-Satellite/scripts/static/main-static/* /var/www/html/ha-home/
# # Create the 'hasatellite' group and user for running the scripts
# echo "Creating group and user 'hasatellite' for running the scripts..."
# if ! id "hasatellite" &>/dev/null; then
#     echo "Creating group and user 'hasatellite' for running the scripts..."
#     sudo groupadd -f hasatellite
#     sudo useradd -r -M -g hasatellite -s /bin/false hasatellite
# else
#     echo "User 'hasatellite' already exists. Skipping user creation."
# fi

# # Create the Python HTTP server script
# echo "Creating Python HTTP server script..."
# cat <<EOF > /usr/src/HA-Satellite/scripts/start_web_server.sh
# #!/bin/bash
# cd /usr/src/HA-Satellite/templates/main/
# python3 -m http.server 8000
# EOF

# # Make the script executable
# sudo chown hasatsatellite:hasatsatellite /usr/src/HA-Satellite/scripts/start_web_server.sh
# chmod +x /usr/src/HA-Satellite/scripts/start_web_server.sh


# # Create a systemd service for the Python HTTP server
# echo "Creating systemd service for the Python HTTP server..."
# cat <<EOF > /etc/systemd/system/web-server.service
# [Unit]
# Description=Local Web Server
# After=network.target

# [Service]
# ExecStart=/usr/src/HA-Satellite/scripts/start_web_server.sh
# Restart=always
# User=hasatellite
# Group=hasatellite

# [Install]
# WantedBy=multi-user.target
# EOF

# # Enable the systemd service to start at boot
# systemctl enable web-server.service

# # Start the service
# systemctl start web-server.service

# echo "Web server setup completed."
