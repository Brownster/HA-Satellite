from flask import Flask, render_template, request, jsonify
import datetime
import paho.mqtt.client as mqtt
import pygame

def play_alarm_sound():
    pygame.mixer.init()
    pygame.mixer.music.load("alarm_sound.mp3")  # Replace with the path to your alarm sound file
    pygame.mixer.music.play()


app = Flask(__name__)

# Store multiple alarm times in a list
alarms = []

# MQTT Configuration
mqtt_broker = "192.168.0.21"  # Replace with your MQTT broker's address
mqtt_port = 1883  # Replace with your MQTT broker's port
mqtt_topic = "home/alarm"

# MQTT Client Setup
mqtt_client = mqtt.Client("AlarmClock")
mqtt_client.connect(mqtt_broker, mqtt_port)

@app.route('/')
def index():
    return render_template('clock-index.html', alarms=alarms)

@app.route('/set_alarm', methods=['POST'])
def set_alarm():
    global alarms
    new_alarm = request.form['alarmTime']
    alarms.append(new_alarm)

    # Publish the updated list of alarms to the MQTT topic
    mqtt_client.publish(mqtt_topic, ','.join(alarms))

    return jsonify(success=True)

@app.route('/check_alarm', methods=['GET'])
def check_alarm():
    global alarms
    now = datetime.datetime.now().strftime("%H:%M")

    triggered_alarms = [alarm for alarm in alarms if alarm == now]

    if triggered_alarms:
        alarms = [alarm for alarm in alarms if alarm != now]  # Remove triggered alarms
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
    app.run(debug=True)
    mqtt_client.loop_start()  # Start MQTT client loop
