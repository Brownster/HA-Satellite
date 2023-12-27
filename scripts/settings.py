from flask import Flask, render_template
import sys
import config # Import config.py

app = Flask(__name__)

@app.route('/settings')
def settings():
    # Read variables from config.py
    settings = {
        'USER_NAME': config.USER_NAME,
        'FILE_PATH': config.FILE_PATH,
        'INSTALL_PATH': config.INSTALL_PATH,
        'REPO_INSTALL_PATH': config.REPO_INSTALL_PATH,
        'DEFAULT_URL': config.DEFAULT_URL,
        'mqtt_host': config.mqtt_host,
        'mqtt_port': config.mqtt_port,
        'SCREEN_NAME': config.SCREEN_NAME,
    }
    return render_template('settings.html', settings=settings)

if __name__ == '__main__':
    app.run(debug=True)

