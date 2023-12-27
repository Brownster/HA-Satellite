import datetime
import time
import json
from playsound import playsound

ALARMS_FILE = '/usr/src/HA-Satellite/scripts/data/alarms.json'  # Ensure this is defined

def read_alarms_from_file(file_path=ALARMS_FILE):
    with open(file_path, 'r') as f:
        return json.load(f)

def save_alarms_to_file(alarms, file_path=ALARMS_FILE):
    with open(file_path, 'w') as f:
        json.dump(alarms, f)

def play_alarm_sound(sound_file):
    playsound(sound_file)

def alarm_monitor(file_path, sound_file):
    while True:
        try:
            alarms = read_alarms_from_file(file_path)
        except FileNotFoundError:
            alarms = []  # If the file does not exist, assume no alarms
        now = datetime.datetime.now().strftime("%H:%M")
        if now in alarms:
            play_alarm_sound(sound_file)
            alarms.remove(now)  # Remove the alarm
            save_alarms_to_file(alarms, file_path)  # Save the updated list of alarms back to file
        time.sleep(60)  # Sleep for 60 seconds before checking again

if __name__ == "__main__":
    alarm_file_path = '/usr/src/HA-Satellite/scripts/data/alarms.json'  # Path to the JSON file where alarms are stored
    alarm_sound_file = '/usr/src/HA-Satellite/scripts/static/alarm.mp3'  # Path to the alarm sound file
    alarm_monitor(alarm_file_path, alarm_sound_file)
