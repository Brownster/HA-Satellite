import RPi.GPIO as GPIO
import time
import subprocess

# GPIO pin for the button
BUTTON_PIN = 17

# Function to read URLs from the local file
def read_urls_from_file():
    with open('kiosk_urls.txt', 'r') as file:
        urls = file.readlines()
    return urls

# Function to update the Chromium URL
def update_chromium_url(new_url):
    subprocess.run(['chromium-browser', '--kiosk', new_url])

# Initialize GPIO
GPIO.setmode(GPIO.BCM)
GPIO.setup(BUTTON_PIN, GPIO.IN, pull_up_down=GPIO.PUD_UP)

try:
    urls = read_urls_from_file()
    current_url_index = 0

    while True:
        # Wait for the button press
        GPIO.wait_for_edge(BUTTON_PIN, GPIO.FALLING)

        # Increment the URL index and loop back if needed
        current_url_index = (current_url_index + 1) % len(urls)

        # Get the new URL
        new_url = urls[current_url_index].strip()

        # Update Chromium with the new URL
        update_chromium_url(new_url)

        # Wait to debounce the button press
        time.sleep(0.2)

finally:
    GPIO.cleanup()
