# config.sh
INSTALL_DIR="/usr/src" # Path to the HA-Satellite wyoming and drivers directorys
INSTALL_PATH="/usr/src/HA-Satellite" # Path to the HA-Satellite repo directory
DEFAULT_URL="http://127.0.0.1/index.html" # Default URL for the homepage
CONFIG_FILE="$INSTALL_PATH/scripts/config.sh" # Path to the config.sh file that holds the variables for the installation scripts
WEBHOST="/var/www/html/" # Path to the homepage hosting directory
USER_GROUP="hasatellite" # User group for the user that will be running the scripts
USER="hasatellite" # User for running the scripts
VENV_DIR="$HOME/my_python_env" # Define the directory for the virtual environment