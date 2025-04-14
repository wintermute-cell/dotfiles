#!/usr/bin/env bash

CUSTOM_NAMES=(
    "usb-Lenovo_ThinkPad_Thunderbolt_3_Dock_USB_Audio_000000000000-00/Lenovo\ Dock"
    "pci-0000_00_1f.3/Internal\ Audio"
    "usb-Focusrite_Scarlett_Solo_USB-00.HiFi__hw_USB_1__sink/Focusrite\ Scarlett"
    "usb-Focusrite_Scarlett_Solo_USB-00/Focusrite\ Scarlett"
    "bluez_sink.F8_4E_17_A0_FF_49.a2dp_sink/Bluetooth\ Headphones"
    )

function run() {
    # List all sinks and extract the sink index and the name
    sinks=$(pactl list short sinks | awk '{ print $1, $2 }')
    # Get the default sink name
    def_sink=$(pactl info | sed -En 's/Default Sink: (.*)/\1/p')
    # Mark the current default sink with a checkmark
    sinks=$(printf "$sinks" | sed -r "s/^(.*?$def_sink.*?)$/\1 ✔/g")

    # Simplify the sink names removing common prefixes and suffixes
    sinks=$(printf "$sinks\n" | sed -r 's/alsa_output\.//g' | sed -r 's/\.analog-stereo//g')
    names_applied=$sinks
    # Apply custom names for better readability
    for ((i = 0; i < ${#CUSTOM_NAMES[@]}; i++)); do
        rename=${CUSTOM_NAMES[$i]}
        names_applied=$(echo "$names_applied" | sed -r "s/$rename/g")
    done
    # Use fuzzel or similar tool to let user select new default sink
    sink_num=$(printf "$names_applied\n" |\
        # fuzzel --dmenu -l 8 -p "Audio Output: " |\
        bemenu -i -l 12 --scrollbar autohide --center -W 0.16 -p "Audio Output: " |\
        awk '{ print $1 }')

    # Set the new default sink using pactl
    if [[ $sink_num != "" ]]; then
        pactl set-default-sink $sink_num
    fi
}

run # Calling the function to execute

