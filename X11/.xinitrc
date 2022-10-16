# prepare environment
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# remaps & general input modifications
/home/wintermute/scripts/remaps.sh

# autostart
udiskie --smart-tray -f pcmanfm &
pa-applet &
dwm_asyncbar.sh &

# background
feh --bg-scale --no-fehbg /home/wintermute/Pictures/wallpapers/bg_glenda.jpg &
exec dwm
