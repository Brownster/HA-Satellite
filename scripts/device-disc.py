import paho.mqtt.client as mqtt
import json

mqtt_host = "192.168.0.21"
mqtt_port = 1883
client = mqtt.Client(client_id="HA-Satellite-1")
client.connect(mqtt_host, mqtt_port)

# Define device information
device_name = "your_screen"
device_unique_id = "screen1"  # You can make this unique for each screen
device_state_topic = f"homeassistant/{device_name}/state"

# Publish discovery message for screen brightness
brightness_config = {
    "name": "Screen Brightness",
    "unique_id": f"{device_unique_id}/brightness",
    "state_topic": device_state_topic,
    "unit_of_measurement": "%",
    "device_class": "brightness",
}

client.publish(f"homeassistant/sensor/{device_name}/brightness/config", json.dumps(brightness_config), retain=True)


# Define device information
device_name = "your_alarm_clock"
device_unique_id = "alarm_clock1"  # You can make this unique for each alarm clock
device_state_topic = f"homeassistant/{device_name}/state"

# Publish discovery message for alarm clock
alarm_clock_config = {
    "name": "Alarm Clock",
    "unique_id": f"{device_unique_id}/alarm",
    "state_topic": device_state_topic,
    "icon": "mdi:clock",
}

client.publish(f"homeassistant/sensor/{device_name}/alarm/config", json.dumps(alarm_clock_config), retain=True)


# Publish discovery message for screen border color
border_color_config = {
    "name": "Screen Border Color",
    "unique_id": f"{device_unique_id}/border_color",
    "state_topic": device_state_topic,
    "effect_list": ["blue", "red"],
}

client.publish(f"homeassistant/sensor/{device_name}/border_color/config", json.dumps(border_color_config), retain=True)

# Similar steps to be added for other devices (volume, on/off, kiosk page)

client.disconnect()
