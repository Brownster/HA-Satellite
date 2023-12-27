import RPi.GPIO as GPIO
import time
import webbrowser
import sys
sys.path.append('/usr/src/HA-Satellite/scripts/')
import config


# GPIO pin for the button
BUTTON_PIN = 17

# URL of the locally hosted webpage
LOCAL_URL = config.DEFAULT_URL

# Initialize GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setup(BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

try:
    while True:
        # Wait for the button press
        GPIO.wait_for_edge(BUTTON_PIN, GPIO.FALLING)

        # Open the locally hosted webpage in a web browser
        webbrowser.open(LOCAL_URL)

        # Wait to debounce the button press
        time.sleep(0.2)

finally:
    GPIO.cleanup()
