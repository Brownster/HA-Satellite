echo "Install drivers for ReSpeaker 2Mic or 4Mic HAT if applicable"
mkdir -p $INSTALL_DIR/respeaker
cd $INSTALL_DIR/respeaker/
git clone https://github.com/respeaker/seeed-voicecard
cd seeed-voicecard
echo running install.sh from seeed-voicecard
sudo bash ./install.sh