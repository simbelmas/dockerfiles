#!/bin/bash

# 1. Identify the host name as the cluster sees it
# We use 'ceph orch host ls' as the source of truth for the hostname
MY_HOST=$(hostname)

echo "Searching for devices on host: $MY_HOST"

# 2. Corrected JQ query for Ceph 20/Squid:
# - .[]: Iterate over each host object
# - select(.name == $HOST): Find the object for this specific host
# - .devices[]: Enter the devices array
# - .path: Extract the string path for every device in that array
DEVICES=$(ceph orch device ls --format json | jq -r --arg HOST "$MY_HOST" '.[] | select(.name == $HOST) | .devices[].path')

if [ -z "$DEVICES" ] || [ "$DEVICES" == "null" ]; then
    echo "No devices found. Checking if the cluster uses 'hostname' instead of 'name'..."
    # Fallback in case your version uses 'hostname' field instead of 'name'
    DEVICES=$(ceph orch device ls --format json | jq -r --arg HOST "$MY_HOST" '.[] | select(.hostname == $HOST) | .devices[].path')
fi

if [ -z "$DEVICES" ] || [ "$DEVICES" == "null" ]; then
    echo "Error: Could not find any devices for host '$MY_HOST'."
    echo "Try running 'ceph orch device ls' to see the host names used by Ceph."
    exit 1
fi

echo "Found the following devices to zap on $MY_HOST:"
echo "$DEVICES"
echo "------------------------------------------------"

for DEV in $DEVICES; do
    echo "Sending zap command for: $DEV"
    
    # We use --force to ensure we clear existing partitions/LVM tags
    ceph orch device zap "$MY_HOST" "$DEV" --force
    
    # Give the orchestrator a moment to queue the task
    sleep 0.5
done

echo "------------------------------------------------"
echo "All commands submitted. Verify progress with: ceph orch ops ls"