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

# Change directory to the repository
cd $REPO_DIR/install

# Run the main.sh script
./main.sh
