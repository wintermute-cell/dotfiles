#!/usr/bin/env python3
import math
import evdev
from evdev import InputDevice, UInput, ecodes as e
import select
import time

# Find your device
devices = [evdev.InputDevice(path) for path in evdev.list_devices()]
device = None
for dev in devices:
    if "Nordic 2.4G Wireless Receiver Mouse" in dev.name:
        device = dev
        break

if not device:
    print("Device not found")
    exit(1)

print(f"Found device: {device.name}")

# Define specific capabilities for the virtual device
capabilities = {
    e.EV_REL: [e.REL_X, e.REL_Y, e.REL_WHEEL, e.REL_HWHEEL],
    e.EV_KEY: [e.BTN_LEFT, e.BTN_RIGHT, e.BTN_MIDDLE, e.BTN_SIDE, e.BTN_EXTRA],
    e.EV_MSC: [e.MSC_SCAN],
}

# Create a virtual device with specific capabilities
ui = UInput(capabilities, name='transformed-trackball')

# Rotation angle in radians (-45 degrees)
angle = math.radians(-70)
cos_val = math.cos(angle)
sin_val = math.sin(angle)

print(f"Using rotation matrix: cos={cos_val}, sin={sin_val}")

# Grab the device to prevent it from sending events to the system
device.grab()

# Process each event immediately for smoother operation
try:
    while True:
        r, w, x = select.select([device], [], [])
        if device in r:
            for event in device.read():
                if event.type == e.EV_REL:
                    if event.code == e.REL_X:
                        # Apply rotation to X component
                        new_x = round(event.value * cos_val)
                        new_y = round(event.value * sin_val)

                        # Only send non-zero values
                        if new_x != 0:
                            ui.write(e.EV_REL, e.REL_X, new_x)
                        if new_y != 0:
                            ui.write(e.EV_REL, e.REL_Y, new_y)

                    elif event.code == e.REL_Y:
                        # Apply rotation to Y component
                        new_x = round(-event.value * sin_val)
                        new_y = round(event.value * cos_val)

                        # Only send non-zero values
                        if new_x != 0:
                            ui.write(e.EV_REL, e.REL_X, new_x)
                        if new_y != 0:
                            ui.write(e.EV_REL, e.REL_Y, new_y)

                    elif event.code in [e.REL_WHEEL, e.REL_HWHEEL]:
                        # Pass through wheel events unchanged
                        ui.write(e.EV_REL, event.code, event.value)

                    # Synchronize after each relative event
                    ui.syn()

                elif event.type == e.EV_KEY:
                    # Pass through button events
                    ui.write(e.EV_KEY, event.code, event.value)
                    ui.syn()

                elif event.type == e.EV_MSC:
                    # Pass through misc events
                    ui.write(e.EV_MSC, event.code, event.value)
                    ui.syn()

except KeyboardInterrupt:
    print("Exiting...")
finally:
    device.ungrab()
    device.close()
    ui.close()

