# config.sh
INSTALL_DIR="/usr/src" # Path to the HA-Satellite wyoming and drivers directorys
INSTALL_PATH="/usr/src/HA-Satellite" # Path to the HA-Satellite repo directory
DEFAULT_URL="http://127.0.0.1/index.html" # Default URL for the homepage
INSTALL_CONFIG_FILE="$INSTALL_PATH/install/config.sh" # Path to the config.sh file that holds the install variables for the installation scripts
PYTHON_CONFIG_FILE="$INSTALL_PATH/scripts/config.py" # Path to the config.py file that holds the Python variables for the installation scripts
WEBHOST="/var/www/html/" # Path to the homepage hosting directory
USER_GROUP="hasatellite" # User group for the user that will be running the scripts
USER="hasatellite" # User for running the scripts
VENV_DIR="$HOME/my_python_env" # Define the directory for the virtual 
USER_NAME="" # Define the user name so i know the home directory
