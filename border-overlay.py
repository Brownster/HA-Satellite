import subprocess
import sys

# Function to overlay a colored border around the screen
def overlay_border(color):
    if color not in ['blue', 'red']:
        print("Invalid color. Supported colors are 'blue' and 'red'.")
        return

    command = f"DISPLAY=:0 xsetroot -solid {color}"
    subprocess.run(command, shell=True)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python border_overlay.py <color>")
        sys.exit(1)

    color = sys.argv[1]
    overlay_border(color)
