#!/bin/bash
#The Home page is available at http://localhost/index.html

sudo mkdir -p /var/www/html/static/
sudo rm -rf /var/www/html/index.html
sudo cp /usr/src/HA-Satellite/scripts/static/main-static/* /var/www/html/static
sudo cp /usr/src/HA-Satellite/scripts/templates/home-index.html /var/www/html/index.html
sudo cp /usr/src/HA-Satellite/scripts/templates/settings.html /var/www/html/settings.html

echo "Home Page setup completed."
echo "The Home page is available at http://localhost/index.html"
