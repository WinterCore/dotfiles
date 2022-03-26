/usr/bin/prime-offload

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile


xrandr --output eDP-1 --mode 2560x1440 --scale 0.75x0.75 --rate 80

xset r rate 250 40

xrdb /home/winter/.Xresources
exec i3

sudo /usr/bin/prime-switch
