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

# Ask for the username
read -p "Enter the username: " username

# Define the home directory of the user
user_home="/home/$username"

# Copy start.sh to the user's home directory
cp /usr/src/HA-Satellite/install/start.sh "$user_home/start.sh"

# Create a symbolic link to config.sh in the user's home directory
ln -s /usr/src/HA-Satellite/install/config.sh "$user_home/config.sh"

# Update the USER_NAME variable in config.sh
sed -i "s/^USER_NAME=\"\"/USER_NAME=\"$username\"/" /usr/src/HA-Satellite/install/config.sh


# Run main.sh with elevated privileges
#sudo bash $REPO_DIR/install/main.sh
