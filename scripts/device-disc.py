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


# Publish discovery message for alarm control (for sending commands)
alarm_control_config = {
    "name": "Alarm Control",
    "unique_id": f"{alarm_device_unique_id}/control",
    "command_topic": alarm_control_topic,
    "state_topic": alarm_state_topic,
    "icon": "mdi:alarm",
    # You can add payload_on, payload_off, etc. if needed
}

client.publish(f"homeassistant/switch/{alarm_device_name}/control/config", json.dumps(alarm_control_config), retain=True)

# Publish discovery message for alarm state (to report the state of the alarm)
alarm_state_config = {
    "name": "Alarm State",
    "unique_id": f"{alarm_device_unique_id}/state",
    "state_topic": alarm_state_topic,
    "icon": "mdi:alarm",
    "device_class": "connectivity",  # You can choose an appropriate device class
}

client.publish(f"homeassistant/binary_sensor/{alarm_device_name}/state/config", json.dumps(alarm_state_config), retain=True)


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