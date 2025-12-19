#!/usr/bin/env bash

# Get current (focused) workspace number
current_ws=$(aerospace list-workspaces --focused)

# Calculate next workspace
next_ws=$((current_ws + 1))

# Get focused window ID (first column from aerospace list-windows --focused)
focused_window=$(aerospace list-windows --focused | awk '{print $1}')

# Move the focused window to the next workspace and switch there
if [[ -n "$focused_window" ]]; then
    aerospace move-node-to-workspace "$next_ws" --window-id "$focused_window"
    aerospace workspace "$next_ws"
fi
