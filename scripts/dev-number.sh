#!/bin/bash

# Include the functions from functions.sh
source "$(dirname "$0")/functions.sh"

# Set the path to the VERSION file
VERSION_FILE="$(dirname "$0")/../VERSION"

# Read the current WORKING_VERSION_DEV_NUMBER value
WORKING_VERSION_DEV_NUMBER=$(read_key_value "$VERSION_FILE" "WORKING_VERSION_DEV_NUMBER")

# If WORKING_VERSION_DEV_NUMBER is empty, assign default value 1
if [ -z "$WORKING_VERSION_DEV_NUMBER" ]; then
    WORKING_VERSION_DEV_NUMBER="1"
    echo "WORKING_VERSION_DEV_NUMBER not found, setting default value to 1."
else
    # Increment the WORKING_VERSION_DEV_NUMBER
    WORKING_VERSION_DEV_NUMBER=$((WORKING_VERSION_DEV_NUMBER + 1))
    echo "Incrementing WORKING_VERSION_DEV_NUMBER to $WORKING_VERSION_DEV_NUMBER."
fi

# Update the VERSION file with the new value of WORKING_VERSION_DEV_NUMBER
write_key_value "$VERSION_FILE" "WORKING_VERSION_DEV_NUMBER" "$WORKING_VERSION_DEV_NUMBER"

# Display the updated WORKING_VERSION_DEV_NUMBER
echo "Updated WORKING_VERSION_DEV_NUMBER=$WORKING_VERSION_DEV_NUMBER"
