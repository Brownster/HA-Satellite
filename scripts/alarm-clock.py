from flask import Flask, render_template, request, jsonify
import datetime
import paho.mqtt.client as mqtt
import pygame

def play_alarm_sound():
    pygame.mixer.init()
    pygame.mixer.music.load("alarm_sound.mp3")  # Replace with the path to your alarm sound file
    pygame.mixer.music.play()

app = Flask(__name__)

alarms = []

mqtt_broker = "192.168.0.21"
mqtt_port = 1883
mqtt_topic = "home/alarm"

mqtt_client = mqtt.Client("AlarmClock")

def on_connect(client, userdata, flags, rc):
    if rc == 0:
        print("Connected to MQTT Broker!")
    else:
        print("Failed to connect, return code %d\n", rc)

mqtt_client.on_connect = on_connect
mqtt_client.subscribe(mqtt_topic)

def on_message(client, userdata, message):
    global alarms
    alarm_list = message.payload.decode("utf-8").split(',')
    alarms = alarm_list

mqtt_client.on_message = on_message

def start_mqtt_client():
    try:
        mqtt_client.connect(mqtt_broker, mqtt_port)
        mqtt_client.loop_start()
    except Exception as e:
        print(f"Error connecting to MQTT broker: {e}")

@app.route('/')
def index():
    return render_template('clock-index.html', alarms=alarms)

# Replace with the path to the file where you want to store the alarms
ALARMS_FILE = 'alarms.json'

def save_alarms_to_file(alarms, file_path=ALARMS_FILE):
    with open(file_path, 'w') as f:
        json.dump(alarms, f)

# Modify the set_alarm function to save the alarms to file
@app.route('/set_alarm', methods=['POST'])
def set_alarm():
    global alarms
    new_alarm = request.form['alarmTime']
    alarms.append(new_alarm)
    save_alarms_to_file(alarms)  # Save the updated list of alarms to file
    mqtt_client.publish(mqtt_topic, ','.join(alarms))
    return jsonify(success=True)

# Modify the stop_alarm function to save the empty alarm list to file
@app.route('/stop_alarm', methods=['POST'])
def stop_alarm():
    global alarms
    alarms = []  # Clear all alarms
    save_alarms_to_file(alarms)  # Save the empty list of alarms to file
    mqtt_client.publish(mqtt_topic, "stop")
    return jsonify(success=True)


@app.route('/check_alarm', methods=['GET'])
def check_current_alarm():
    global alarms
    now = datetime.datetime.now().strftime("%H:%M")
    triggered_alarms = [alarm for alarm in alarms if alarm == now]
    if triggered_alarms:
        alarms = [alarm for alarm in alarms if alarm != now]
        return jsonify(alarm=True)
    return jsonify(alarm=False)

@app.route('/snooze_alarm', methods=['POST'])
def snooze_alarm():
    global alarms
    snooze_time = request.form.get('snoozeTime', '5')  # Default snooze time is 5 minutes

    new_alarms = []
    for alarm in alarms:
        if alarm == datetime.datetime.now().strftime("%H:%M"):
            hour, minute = map(int, alarm.split(':'))
            alarm = datetime.datetime.now().replace(hour=hour, minute=minute)
            alarm += datetime.timedelta(minutes=int(snooze_time))
            alarms.append(alarm.strftime("%H:%M"))
        else:
            new_alarms.append(alarm)
    
    alarms = new_alarms

   
    # Publish the updated list of alarms to the MQTT topic
    mqtt_client.publish(mqtt_topic, ','.join(alarms))

    return jsonify(success=True)

@app.route('/check_alarm', methods=['GET'])
def check_alarm():
    global alarms
    now = datetime.datetime.now().strftime("%H:%M")

    triggered_alarms = [alarm for alarm in alarms if alarm == now]

    if triggered_alarms:
        play_alarm_sound()
        alarms = [alarm for alarm in alarms if alarm != now]  # Remove triggered alarms
        return jsonify(alarm=True)

    return jsonify(alarm=False)

@app.route('/stop_alarm', methods=['POST'])
def stop_alarm():
    global alarms
    alarms = []  # Clear all alarms

    # Publish the alarm stop signal to the MQTT topic
    mqtt_client.publish(mqtt_topic, "stop")

    return jsonify(success=True)

# MQTT Message Handler
def on_message(client, userdata, message):
    global alarms
    alarm_list = message.payload.decode("utf-8").split(',')
    alarms = alarm_list

# Subscribe to MQTT Topic
mqtt_client.subscribe(mqtt_topic)
mqtt_client.on_message = on_message

@app.route('/get_alarms', methods=['GET'])
def get_alarms():
    return jsonify(alarms=alarms)

if __name__ == '__main__':
    start_mqtt_client()
    app.run(debug=True)
