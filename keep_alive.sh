#!/usr/bin/env sh

# Function to keep the connection alive
keep_alive() {
    # Define a hidden lock file
    local LOCK_FILE="$HOME/.keep_alive.lock"

    # Check if the lock file exists
    if [ -f "$LOCK_FILE" ]; then
        echo "Another instance of keep_alive is already running."
        return 1
    fi

    # Create the lock file
    touch "$LOCK_FILE"

    # Ensure the lock file is removed when the script exits
    trap "rm -f $LOCK_FILE" EXIT

    echo "Starting keep_alive function..."

    # Loop to send ping requests
    while true; do
        ping -c 1 8.8.8.8 > /dev/null
        sleep 60
    done
}
