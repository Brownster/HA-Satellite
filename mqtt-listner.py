import os
import paho.mqtt.client as mqtt

mqtt_host = "your_mqtt_broker_ip"
mqtt_port = 1883
topic = "homeassistant/your_screen/state"

def on_connect(client, userdata, flags, rc):
    print("Connected to MQTT Broker with result code " + str(rc))
    client.subscribe(topic)

def on_message(client, userdata, msg):
    message = msg.payload.decode("utf-8")
    print("Received message on topic: " + msg.topic + " - Message: " + message)

    # Parse the message and take appropriate action
    if msg.topic == topic:
        try:
            brightness = int(message)  # Try to convert the message to an integer
            # Implement code to set screen brightness to the received value
            print(f"Setting screen brightness to {brightness}%")
            os.system(f"xbacklight -set {brightness}")  # This command works on Linux with xbacklight installed
        except ValueError:
            print("Received invalid brightness value")

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(mqtt_host, mqtt_port, 60)

# Start the MQTT loop
client.loop_forever()
