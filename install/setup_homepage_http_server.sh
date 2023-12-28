#!/bin/bash
#The Home page is available at http://localhost/index.html
source "$(dirname "$0")/config.sh"

sudo mkdir -p $WEBHOST/static/
sudo rm -rf $WEBHOST/index.html
sudo cp $INSTALL_PATH/scripts/static/main-static/* $WEBHOST/static
sudo cp $INSTALL_PATH/scripts/templates/home-index.html $WEBHOST/index.html
sudo cp $INSTALL_PATH/scripts/templates/settings.html $WEBHOST/settings.html

echo "Home Page setup completed."
echo "The Home page is available at http://localhost/index.html"
