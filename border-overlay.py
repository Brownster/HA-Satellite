import subprocess
import sys
import time

# Function to overlay a colored border around the screen
def overlay_border(color):
    if color not in ['blue', 'red']:
        print("Invalid color. Supported colors are 'blue' and 'red'.")
        return

    command = f"DISPLAY=:0 xsetroot -solid {color}"
    subprocess.run(command, shell=True)

# Function to remove the overlay after a specified delay
def remove_overlay(timeout):
    time.sleep(timeout)
    subprocess.run("DISPLAY=:0 xsetroot -solid black", shell=True)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python border_overlay.py <color>")
        sys.exit(1)

    color = sys.argv[1]
    overlay_border(color)

    # Set the timeout (in seconds)
    timeout = 3
    remove_overlay(timeout)
