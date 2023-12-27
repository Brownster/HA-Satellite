from flask import Flask, request, render_template
from manage_cron import manage_cron_job
def get_cron_jobs_with_identifier(identifier):
    cron = CronTab(user=True)
    jobs = []

    for job in cron:
        if job.comment == identifier:
            schedule = job.slices.render()
            # Assuming the schedule is in a "minute hour * * day" format
            minutes, hours, _, _, day = schedule.split()
            formatted_day = ["Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"][int(day)]
            formatted_time = f"{int(hours):02d}:{int(minutes):02d}"
            jobs.append({'day': formatted_day, 'time': formatted_time})

    return jobs

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    if request.method == "POST":
        day = request.form.get("day")
        hours = request.form.get("hours")
        minutes = request.form.get("minutes")
        action = request.form.get("action")
        identifier = request.form.get("identifier")

        time = f"{hours}:{minutes}"
        result = manage_cron_job(day, time, action, identifier)
        return render_template("index.html", result=result)

    return render_template("index.html", result=None)

