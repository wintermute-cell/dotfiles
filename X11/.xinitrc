# prepare environment
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# remaps & general input modifications
/home/wintermute/scripts/remaps.sh

# setting correct display configuration, depending if dock is present
/home/wintermute/scripts/dock_toggle.sh &

# autostart
udiskie --smart-tray -f pcmanfm &
volumeicon &
dwm_asyncbar.sh &
nm-applet &
caffeine &

# background
feh --bg-scale --no-fehbg /home/wintermute/Pictures/wallpapers/bg_glenda.jpg &
exec dwm
