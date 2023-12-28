from crontab import CronTab

def manage_cron_job(day, time, action, identifier):
    # Days of the week in cron format
    days = {
        "sunday": 0,
        "monday": 1,
        "tuesday": 2,
        "wednesday": 3,
        "thursday": 4,
        "friday": 5,
        "saturday": 6
    }

    # Validate input
    if day.lower() not in days:
        raise ValueError("Invalid day of the week")
    if ':' not in time:
        raise ValueError("Time must be in HH:MM format")
    
    hours, minutes = time.split(':')
    cron_time = f"{minutes} {hours} * * {days[day.lower()]}"
    
    # Access current user's crontab
    cron = CronTab(user=True)
    job_string = f"/usr/src/HA-Satellte/scripts/alarm_clock/play.sh # {identifier}"

    if action.lower() == 'create':
        job = cron.new(command=job_string, comment=identifier)
        job.setall(cron_time)
        cron.write()
        return "Cron job created."
    
    elif action.lower() == 'remove':
        cron.remove_all(comment=identifier)
        cron.write()
        return "Cron job removed."

    else:
        raise ValueError("Action must be 'create' or 'remove'")

# Example usage
print(manage_cron_job("tuesday", "07:30", "create", "Spotify Alarm"))