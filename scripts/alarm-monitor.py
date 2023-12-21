import datetime
import time
import json
from playsound import playsound

def read_alarms_from_store(file_path):
    with open(file_path, 'r') as f:
        return json.load(f)

def play_alarm_sound(sound_file):
    playsound(sound_file)

def alarm_monitor(file_path, sound_file):
    while True:
        # Read the current set of alarms
        alarms = read_alarms_from_store(file_path)
        now = datetime.datetime.now().strftime("%H:%M")
        if now in alarms:
            play_alarm_sound(sound_file)
            # Optionally, remove the alarm from the list if it should only play once
        time.sleep(60)  # Check every minute

if __name__ == "__main__":
    alarm_file_path = 'alarms.json'  # Path to the JSON file where alarms are stored
    alarm_sound_file = 'path/to/alarm_sound.mp3'  # Path to the alarm sound file
    alarm_monitor(alarm_file_path, alarm_sound_file)
