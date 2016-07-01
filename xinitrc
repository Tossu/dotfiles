if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

setxkbmap -option "nbsp:none" -layout fi
feh --bg-scale ~/.dotfiles/wallpapers/current.png
xautolock -time 15 -locker slock &
pulseaudio &
nm-applet &
xrandr --output HDMI1 --mode 1920x1080 --left-of eDP1 &
exec i3
