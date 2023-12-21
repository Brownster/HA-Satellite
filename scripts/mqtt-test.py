import paho.mqtt.client as mqtt

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected successfully.")
    else:
        print(f"Connected with result code {rc}")

# Create an MQTT client instance
client = mqtt.Client()

# Assign the on_connect callback function
client.on_connect = on_connect

# Connect to the MQTT broker
client.connect("192.168.0.21", 1883, 60)

# Start the network loop
client.loop_forever()