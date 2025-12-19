#!/usr/bin/env bash

# Step 1: Get current focused monitor
current_monitor=$(aerospace list-monitors --focused | awk '{print $1}')

# Step 2: Get current workspace
current_ws=$(aerospace list-workspaces --focused)

# Step 3: Get the first empty workspace on that monitor
next_empty=$(aerospace list-workspaces --monitor "$current_monitor" --empty | head -n1)

# Step 4: Decide where to go
if [ "$current_ws" == "$next_empty" ]; then
    # Already on the next empty, go to previous workspace instead
    aerospace workspace-back-and-forth
else
    # Move to the next empty workspace
    aerospace workspace "$next_empty"
fi
