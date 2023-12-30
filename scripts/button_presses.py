import RPi.GPIO as GPIO
import subprocess
import signal

# Function to handle cleanup on termination
def cleanup(signum, frame):
    GPIO.cleanup()
    exit(0)

# Setup signal handler to ensure GPIO cleanup on termination
signal.signal(signal.SIGTERM, cleanup)
signal.signal(signal.SIGINT, cleanup)

# GPIO setup
GPIO.setmode(GPIO.BCM)
back_button_pin = 17  # replace with your GPIO pin number
home_button_pin = 27  # replace with your GPIO pin number

GPIO.setup(back_button_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(home_button_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)

def back(channel):
    subprocess.run(['xdotool', 'key', 'alt+Left'])

def home(channel):
    subprocess.run(['xdotool', 'key', 'F5'])  # Refresh page as home action

GPIO.add_event_detect(back_button_pin, GPIO.FALLING, callback=back, bouncetime=300)
GPIO.add_event_detect(home_button_pin, GPIO.FALLING, callback=home, bouncetime=300)

# Infinite loop to keep the script running
while True:
    pass
