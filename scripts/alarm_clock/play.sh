#!/bin/bash

# Path to the WAV file
WAV_FILE="/usr/src/scripts/alarm_clock/alarm_sound.wav"

# Check if the WAV file exists
if [ ! -f "$WAV_FILE" ]; then
    echo "Error: WAV file not found."
    exit 1
fi

# Play the WAV file
aplay "$WAV_FILE"