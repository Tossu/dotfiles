if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -x /usr/bin/autocutsel ]; then
    autocutsel -selection CLIPBOARD -fork
    autocutsel -selection PRIMARY -fork
fi

tpset() { xinput set-prop "TPPS/2 IBM TrackPoint" "$@"; }

tpset "Evdev Wheel Emulation" 1
tpset "Evdev Wheel Emulation Button" 2
tpset "Evdev Wheel Emulation Timeout" 200
tpset "Evdev Wheel Emulation Axes" 6 7 4 5
tpset "Device Accel Constant Deceleration" 0.95

setxkbmap -option "nbsp:none" -layout fi
feh --bg-scale ~/.dotfiles/wallpapers/current.png
xautolock -time 15 -locker slock &
pulseaudio &
nm-applet &
xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1 &
exec i3
