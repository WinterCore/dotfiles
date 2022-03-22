[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

xrandr --output eDP --scale 0.75x0.75

xset r rate 250 40

exec i3
