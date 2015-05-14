setxkbmap -option "nbsp:none" -layout fi
feh --bg-scale ~/.wallpaper.jpg
xautolock -time 30 -locker slock &
/usr/bin/start-pulseaudio-x11 &
exec i3
