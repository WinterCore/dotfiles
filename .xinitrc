xrdb ~/.Xresources

xrandr --output DisplayPort-1 --rate 144 --primary --mode 1920x1080 --pos 1080x580 --output HDMI-A-0 --mode 1920x1080 --rotate left --pos 0x0

xset r rate 250 40

xmodmap ~/.config/swap_caps_with_escape

exec i3

