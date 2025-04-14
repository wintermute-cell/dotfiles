#!/usr/bin/env bash

declare -A ACTIONS
ACTIONS=()
ACTIONS["1 Screenshot Area"]="grimshot copy area"
if test $(pgrep wf-recorder); then
    ACTIONS["2 Stop Recording"]="killall -s SIGINT wf-recorder"
else
    ACTIONS["2 Start Recording"]="wf-recorder --file \"\$HOME/Videos/recording_\$(date +%d_%m_%y-%H:%M:%S).mp4\" -g \"\$(slurp)\" -r 24 -x yuv420p"
fi
if test $(pgrep wf-recorder); then
    ACTIONS["3 Stop Recording"]="killall -s SIGINT wf-recorder"
else
    ACTIONS["3 Start Recording + Audio"]="wf-recorder --file \"\$HOME/Videos/recording_\$(date +%d_%m_%y-%H:%M:%S).mp4\" -g \"\$(slurp)\" -r 24 -x yuv420p --audio=alsa_output.usb-Focusrite_Scarlett_Solo_USB-00.HiFi__hw_USB_1__sink.monitor"
fi
ACTIONS["4 Screenshot Area to File"]="grimshot savecopy area"
ACTIONS["5 Screenshot Screen"]="grimshot anything"
ACTIONS["6 Screenshot All Screens"]="grimshot copy screen"

# Define the order of the keys
ORDERED_KEYS=(
    "1 Screenshot Area"
    "2 Stop Recording"
    "2 Start Recording"
    "3 Stop Recording"
    "3 Start Recording + Audio"
    "4 Screenshot Area to File"
    "5 Screenshot Screen"
    "6 Screenshot All Screens"
)

function run() {
    action_key=$(for key in "${ORDERED_KEYS[@]}"; do
        if [[ -n "${ACTIONS[$key]}" ]]; then
            echo "${key}"
        fi
    done | bemenu -i -l 12 --scrollbar autohide --center -W 0.16 -p "Screencap: ")

    if [[ -z "${action_key}" ]]; then
        exit 0
    fi

    # Use eval to delay expansion
    eval ${ACTIONS[$action_key]}
}
run

