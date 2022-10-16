# prepare environment
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# set $PATH
export PATH="/home/wintermute/.local/bin:$PATH"

# remaps & general input modifications
/home/wintermute/scripts/remaps.sh

# autostart
udiskie --tray &
pa-applet &
dwm_asyncbar.sh &

# background
feh --bg-scale --no-fehbg /home/wintermute/Pictures/bg_glenda.jpg &
exec dwm
