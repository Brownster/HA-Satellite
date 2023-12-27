#!/bin/bash
#The Home page is available at http://localhost/index.html
source "$(dirname "$0")/config.sh"

sudo mkdir -p /var/www/html/static/
sudo rm -rf /var/www/html/index.html
sudo cp $INSTALL_PATH/scripts/static/main-static/* /var/www/html/static
sudo cp $INSTALL_PATH/scripts/templates/home-index.html /var/www/html/index.html
sudo cp $INSTALL_PATH/scripts/templates/settings.html /var/www/html/settings.html

echo "Home Page setup completed."
echo "The Home page is available at http://localhost/index.html"
