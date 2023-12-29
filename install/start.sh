#!/bin/bash
source "$(dirname "$0")/config.sh"

# script to restart the installation process after reboot.

# cd to the install directory
cd "$INSTALL_DIR/install"
sudo bash main.sh
