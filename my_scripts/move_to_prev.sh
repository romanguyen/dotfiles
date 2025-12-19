#!/usr/bin/env bash

# Get current (focused) workspace number
current_ws=$(aerospace list-workspaces --focused)

# Calculate previous workspace (avoid going below 1)
prev_ws=$((current_ws - 1))
if [[ $prev_ws -lt 1 ]]; then
    echo "Already at the first workspace, can't go lower."
    exit 1
fi

# Get focused window ID (first column from aerospace list-windows --focused)
focused_window=$(aerospace list-windows --focused | awk '{print $1}')

# Move the focused window to the previous workspace and switch there
if [[ -n "$focused_window" ]]; then
    aerospace move-node-to-workspace "$prev_ws" --window-id "$focused_window"
    aerospace workspace "$prev_ws"
fi
