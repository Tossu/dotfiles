if [ -d /etc/X11/xinit/xinitrc.d ] ; then
    for f in /etc/X11/xinit/xinitrc.d/?* ; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

setxkbmap -option "nbsp:none" -layout fi
feh --bg-scale ~/.dotfiles/wallpapers/current.jpg
xautolock -time 15 -locker slock &
start-pulseaudio-x11 &
exec i3
