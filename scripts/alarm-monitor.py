import datetime
import time
import json
from playsound import playsound

def read_alarms_from_store(file_path):
    with open(file_path, 'r') as f:
        return json.load(f)

def play_alarm_sound(sound_file):
    playsound(sound_file)

def read_alarms_from_file(file_path=ALARMS_FILE):
    with open(file_path, 'r') as f:
        return json.load(f)

def alarm_monitor(file_path, sound_file):
    while True:
        try:
            alarms = read_alarms_from_file(file_path)
        except FileNotFoundError:
            alarms = []  # If the file does not exist, assume no alarms
        now = datetime.datetime.now().strftime("%H:%M")
        if now in alarms:
            play_alarm_sound(sound_file)
            alarms.remove(now)  # Optionally, remove the alarm
            save_alarms_to_file(alarms)  # Save the updated list of alarms back to file
        time.sleep(60)  # Sleep for 60 seconds before checking again


if __name__ == "__main__":
    alarm_file_path = 'alarms.json'  # Path to the JSON file where alarms are stored
    alarm_sound_file = 'path/to/alarm_sound.mp3'  # Path to the alarm sound file
    alarm_monitor(alarm_file_path, alarm_sound_file)
