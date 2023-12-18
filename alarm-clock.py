from flask import Flask, render_template, request, jsonify
import datetime

app = Flask(__name__)

# Store alarm time
alarm_time = None

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/set_alarm', methods=['POST'])
def set_alarm():
    global alarm_time
    alarm_time = request.form['alarmTime']
    return jsonify(success=True)

@app.route('/check_alarm', methods=['GET'])
def check_alarm():
    global alarm_time
    if alarm_time and datetime.datetime.now().strftime("%H:%M") == alarm_time:
        alarm_time = None  # Reset alarm time
        return jsonify(alarm=True)
    return jsonify(alarm=False)

@app.route('/snooze_alarm', methods=['POST'])
def snooze_alarm():
    global alarm_time
    if alarm_time:
        # Parse the current alarm time
        hour, minute = map(int, alarm_time.split(':'))
        # Create a datetime object for the alarm
        alarm = datetime.datetime.now().replace(hour=hour, minute=minute)
        # Add 5 minutes to the alarm time
        alarm += datetime.timedelta(minutes=5)
        # Update the alarm time
        alarm_time = alarm.strftime("%H:%M")
    return jsonify(success=True)

@app.route('/stop_alarm', methods=['POST'])
def stop_alarm():
    global alarm_time
    alarm_time = None  # Reset alarm time
    return jsonify(success=True)

if __name__ == '__main__':
    app.run(debug=True)
