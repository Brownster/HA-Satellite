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
        if message == "80":  # Assuming "80" represents 80% brightness
            # Implement code to set screen brightness to 80%
            print("Setting screen brightness to 80%")
            # You can call functions or execute commands to adjust screen brightness here

client = mqtt.Client()
client.on_connect = on_connect
client.on_message = on_message

client.connect(mqtt_host, mqtt_port, 60)

# Start the MQTT loop
client.loop_forever()
