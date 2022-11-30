#!/usr/bin/env bash

###############
## AUTOSTART ##
###############
dunst & > /dev/null
nm-applet --indicator & > /dev/null
blueman-applet & > /dev/null
killall udiskie; udiskie --smart-tray -f pcmanfm & > /dev/null
caffeine & > /dev/null
