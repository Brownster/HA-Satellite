#!/bin/bash
cd /usr/src/
# The URL of the GitHub repository
REPO_URL="https://github.com/Brownster/HA-Satellite.git"
# The directory name that GitHub will clone into
REPO_DIR="HA-Satellite"

# Check if Git is installed
if ! command -v git &> /dev/null
then
    echo "Git is not installed. Installing Git..."
    sudo apt-get update
    sudo apt-get install git -y
fi

# Clone the repository
git clone $REPO_URL

# Change permissions for all .sh files in the install directory
chmod +x $REPO_DIR/install/*.sh

# Run main.sh with elevated privileges
#sudo bash $REPO_DIR/install/main.sh
