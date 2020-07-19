"""
Simple diet technique

To try to lose weight keep to a calorie rate per hour

Target 1560 with a 24 hour period. This translates to a 65 calorie per hour rate.

The trick is to set a target as to when one can eat agian on the load of calories that was consumed

Author Robert Munnoch
"""

import datetime

target_daily_calories = 1560.0
rate = target_daily_calories/24.0

calories = input("How many calories comsumed?\n")

try:
	calories = float(calories)
except:
	raise Exception("Calories entered must be a number e.g. 100")

hour_wait = calories / rate

dt = datetime.timedelta(hours=hour_wait)
current = datetime.datetime.now()

target = current+ dt

print(f"Current Time: {current.isoformat()}")
print(f"hours to wait: {hour_wait:0.3f}")
print(f"Target time to wait till next meal: {target.isoformat()}")