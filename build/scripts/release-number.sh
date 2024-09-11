#!/bin/bash

# Include the functions from functions.sh
source "$(dirname "$0")/functions.sh"

# Set the path to the VERSION file
VERSION_FILE="$(dirname "$0")/../VERSION"

# Check if VERSION file exists
if [ ! -f "$VERSION_FILE" ]; then
    echo "Error: VERSION file not found!"
    exit 1
fi

# Argument validation
if [ -z "$1" ]; then
    echo "Error: You must provide a version argument."
    exit 1
fi

VERSION_ARG="$1"
KEY_NAME="RELEASE_VERSION_${VERSION_ARG//./_}_NUMBER"

# If --del flag is provided, delete the key
if [ "$2" == "--del" ]; then
    delete_key "$VERSION_FILE" "$KEY_NAME"
    echo "$KEY_NAME has been deleted."
    exit 0
fi

# Read the current RELEASE_VERSION_[VERSION]_NUMBER value
RELEASE_VERSION_NUMBER=$(read_key_value "$VERSION_FILE" "$KEY_NAME")

# If RELEASE_VERSION_[VERSION]_NUMBER is empty, assign default value 1
if [ -z "$RELEASE_VERSION_NUMBER" ]; then
    RELEASE_VERSION_NUMBER="1"
    echo "$KEY_NAME not found, setting default value to 1."
else
    # Increment the RELEASE_VERSION_[VERSION]_NUMBER
    RELEASE_VERSION_NUMBER=$((RELEASE_VERSION_NUMBER + 1))
    echo "Incrementing $KEY_NAME to $RELEASE_VERSION_NUMBER."
fi

# Update the VERSION file with the new value of RELEASE_VERSION_[VERSION]_NUMBER
write_key_value "$VERSION_FILE" "$KEY_NAME" "$RELEASE_VERSION_NUMBER"

# Display the updated RELEASE_VERSION_[VERSION]_NUMBER
echo "Updated $KEY_NAME=$RELEASE_VERSION_NUMBER"
