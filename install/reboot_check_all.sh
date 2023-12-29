#!/bin/bash
source "$(dirname "$0")/config.sh"

if [ "$SCRIPT_RESTART" = "true" ]; then
    echo "Detected a reboot after installation of desktop. Continuing installation..."
    $INSTALL_PATH/install/install_chromium_kiosk.sh

else
    $INSTALL_PATH/install/update.sh
fi
