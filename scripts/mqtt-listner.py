import os
import subprocess
import paho.mqtt.client as mqtt

mqtt_host = "192.168.0.21"
mqtt_port = 1883
# Define a topic for setting the border screen brightness
brightness_topic = "homeassistant/your_screen/brightness"
# Define a topic for setting the border
border_topic = "homeassistant/your_screen/border"  # Define topic for setting the border
# Define topic for setting and deleting alarms
alarm_topic = "homeassistant/alarm/control"
def on_connect(client, userdata, flags, rc):
    print("Connected to MQTT Broker with result code " + str(rc))
    client.subscribe(brightness_topic)
    client.subscribe(border_topic)  # Subscribe to the border topic

def on_message(client, userdata, msg):
    message = msg.payload.decode("utf-8")
    print("Received message on topic: " + msg.topic + " - Message: " + message)

    # Parse the message and take appropriate action
    if msg.topic == brightness_topic:
        try:
            brightness = int(message)  # Try to convert the message to an integer
            # Implement code to set screen brightness to the received value
            print(f"Setting screen brightness to {brightness}%")
            os.system(f"xbacklight -set {brightness}")  # This command works on Linux with xbacklight installed
        except ValueError:
            print("Received invalid brightness value")
    elif msg.topic == border_topic:  # Check if the message is for setting the border
        if message.lower() == "blue":
            overlay_border("blue")
        elif message.lower() == "red":
            overlay_border("red")
        else:
            print("Received invalid border color")
    elif msg.topic == alarm_topic:
        alarm_message = msg.payload.decode("utf-8")
        handle_alarm_control(alarm_message)

# Function to overlay a colored border around the screen
def overlay_border(color):
    if color not in ['blue', 'red', 'green', 'orange']:
        print("Invalid color. Supported colors are 'blue', 'red', 'green', 'orange'.")
        return

    command = f"DISPLAY=:0 xsetroot -solid {color}"
    os.system(command)

def handle_alarm_control(message):
    # Example message format: "Monday 18:30 create"
    parts = message.split()
    if len(parts) != 3:
        print("Invalid alarm control message format")
        return

    day, time, action = parts
    if action.lower() not in ["create", "remove"]:
        print("Invalid action for alarm control")
        return

    # Assuming spotify-alarm.py takes arguments in the format: day time action
    command = ["python", "/usr/src/HA-Satellite/scripts/alarm_clock/manage-cron.py", day, time, action]
    subprocess.run(command)


client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(mqtt_host, mqtt_port, 60)

# Start the MQTT loop
client.loop_forever()
