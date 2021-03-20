#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep1; done

# Launch polybar
MONITOR=DisplayPort-1 polybar main &
# MONITOR=HDMI-A-0 polybar second &
