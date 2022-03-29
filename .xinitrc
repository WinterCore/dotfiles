 xrandr --setprovideroutputsource NVIDIA-G0 modesetting
# xrandr --setprovideroutputsource modesetting NVIDIA-0
# xrandr --output eDP-1 --mode 2560x1440 --scale 0.75x0.75 --rate 80

[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile

xset r rate 200 50

xrdb /home/winter/.Xresources

exec i3
