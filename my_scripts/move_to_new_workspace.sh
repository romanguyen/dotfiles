#!/usr/bin/env bash

# Step 1: Get current focused monitor
current_monitor=$(aerospace list-monitors --focused | awk '{print $1}')

# Step 3: Get the first empty workspace on that monitor
next_empty=$(aerospace list-workspaces --monitor "$current_monitor" --empty | head -n1)

aerospace move-node-to-workspace "$next_empty"
aerospace workspace "$next_empty"
