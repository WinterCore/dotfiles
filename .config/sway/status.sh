#!/bin/bash

date_formatted=$(date "+%a %F %I:%M %p")

battery_status=" $(cat /sys/class/power_supply/BAT0/capacity)%"

temps=" $(node /home/winter/.scripts/temps)"

brightness_actual=$(cat /sys/class/backlight/amdgpu_bl0/brightness)
brightness_max=$(cat /sys/class/backlight/amdgpu_bl0/max_brightness)
brightness_value=$(echo $brightness_actual $brightness_max | awk '{ print $1/$2*100 }' | awk -F. '{ print $1 }')
brightness=" $brightness_value%"

string=$(free -m | grep Mem)
used=$(echo $string | awk '{print $3}')
total=$(echo $string | awk '{print $2}')
memory_percentage=$(echo $used $total | awk '{ print $1/$2*100 }' | awk -F. '{ print $1 }')

ram=" $memory_percentage%"

volume=" $(awk '{ print $1 }' <(pulsemixer --get-volume))"

# echo "$temps   $ram   $brightness   $battery_status   $volume   $date_formatted"
echo "$volume   $battery_status   $temps   $brightness   $ram   $date_formatted"
