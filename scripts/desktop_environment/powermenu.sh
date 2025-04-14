#!/usr/bin/env bash

declare -A ACTIONS
ACTIONS=()
ACTIONS["1 Shutdown"]="systemctl poweroff"
ACTIONS["2 Restart"]="systemctl reboot"
ACTIONS["3 Suspend"]="systemctl suspend"
# ACTIONS["4 To TTY"]="killall .Hyprland-wrapped || killall sway || killall dwl"
ACTIONS["4 To TTY"]="riverctl exit"

function run() {
    action_key=$(for key in "${!ACTIONS[@]}"; do echo "${key}"; done |\
        # fuzzel --dmenu -l 5 -p "パワー: ")
        bemenu -i -l 12 --scrollbar autohide --center -W 0.16 -p "パワー: ")
    if [[ -z "${action_key}" ]]; then
        exit 0
    fi
    ${ACTIONS[$action_key]}
}

run
