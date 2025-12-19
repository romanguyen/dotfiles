#!/bin/bash
# Swap all windows between monitor 1 and monitor 2 in Aerospace

workspace1=($(aerospace list-workspaces --monitor 1 --visible))
workspace2=($(aerospace list-workspaces --monitor 2 --visible))

# Get all window IDs on monitor 1
windows1=($(aerospace list-windows --workspace $workspace1 --json | jq -r '.[].["window-id"]'))

# Get all window IDs on monitor 2
windows2=($(aerospace list-windows --workspace $workspace2 --json | jq -r '.[].["window-id"]'))

# Case 1: Both monitors empty
if [ ${#windows1[@]} -eq 0 ] && [ ${#windows2[@]} -eq 0 ]; then
    exit 0
fi

# Case 2: Monitor 1 empty, monitor 2 has windows → move windows to monitor 1
if [ ${#windows1[@]} -eq 0 ] && [ ${#windows2[@]} -gt 0 ]; then
    for win in "${windows2[@]}"; do
        aerospace move-node-to-monitor --window-id "$win" prev
    done
    exit 0
fi

# Case 3: Monitor 2 empty, monitor 1 has windows → move windows to monitor 2
if [ ${#windows2[@]} -eq 0 ] && [ ${#windows1[@]} -gt 0 ]; then
    for win in "${windows1[@]}"; do
        aerospace move-node-to-monitor --window-id "$win" next
    done
    exit 0
fi

# Case 4: Both monitors have windows → swap them
# Move monitor 2 windows to monitor 1 first
for win in "${windows2[@]}"; do
    aerospace move-node-to-monitor --window-id "$win" prev
done

# Move monitor 1 windows to monitor 2
for win in "${windows1[@]}"; do
    aerospace move-node-to-monitor --window-id "$win" next
done
