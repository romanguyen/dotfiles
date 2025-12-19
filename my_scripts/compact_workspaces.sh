#!/usr/bin/env bash
# compact_workspaces.sh — for AeroSpace

# Path to the CLI if not in $PATH
AERO="aerospace"

# Get all windows with their workspace IDs
# We'll get JSON list of windows, workspace info
mapfile -t windows < <("$AERO" query --windows --all \
    | jq -r '.[] | "\(.node_id) \(.workspace)"')

declare -A workspace_windows

for win in "${windows[@]}"; do
    win_id=$(cut -d ' ' -f 1 <<< "$win")
    ws=$(cut -d ' ' -f 2 <<< "$win")
    workspace_windows["$ws"]+="$win_id "
done

# Get all used workspaces, sorted numerically (assuming numeric names)
used_workspaces=($(printf "%s\n" "${!workspace_windows[@]}" | sort -n))

target_ws=1
for src_ws in "${used_workspaces[@]}"; do
    if (( src_ws > target_ws )); then
        for win_id in ${workspace_windows[$src_ws]}; do
            # Move the window (node) to the target workspace
            # command syntax: move-node-to-workspace <workspace>
            "$AERO" dispatch move-node-to-workspace "$target_ws,node:$win_id"
        done
    fi
    ((target_ws++))
done

echo "Compaction complete: used workspaces re‑numbered from 1 to $((target_ws-1))"
