#!/bin/bash

# Include the functions from functions.sh
source "$(dirname "$0")/functions.sh"

# Set the path to the VERSION file
VERSION_FILE="$(dirname "$0")/../VERSION"

# Default values if the VERSION file does not exist
DEFAULT_MAJOR="1"
DEFAULT_WORKING_VERSION="1.0.0"
DEFAULT_WORKING_VERSION_DEV_NUMBER="1"

# Create VERSION file if it doesn't exist and initialize default values
if [ ! -f "$VERSION_FILE" ]; then
    echo "Creating VERSION file with default values..."
    echo "MAJOR=$DEFAULT_MAJOR" > "$VERSION_FILE"
    echo "WORKING_VERSION=$DEFAULT_WORKING_VERSION" >> "$VERSION_FILE"
    echo "WORKING_VERSION_DEV_NUMBER=$DEFAULT_WORKING_VERSION_DEV_NUMBER" >> "$VERSION_FILE"
fi

# Read current values from the VERSION file
MAJOR=$(read_key_value "$VERSION_FILE" "MAJOR")
WORKING_VERSION=$(read_key_value "$VERSION_FILE" "WORKING_VERSION")
WORKING_VERSION_DEV_NUMBER=$(read_key_value "$VERSION_FILE" "WORKING_VERSION_DEV_NUMBER")

# Extract the major and minor version components from WORKING_VERSION
CURRENT_MAJOR=$(echo "$WORKING_VERSION" | cut -d'.' -f1)
CURRENT_MINOR=$(echo "$WORKING_VERSION" | cut -d'.' -f2)

# Get the major version argument, if provided
ARG_MAJOR=$1

# If a major version argument is provided and is different from the current MAJOR value
if [ -n "$ARG_MAJOR" ] && [ "$ARG_MAJOR" != "$MAJOR" ]; then
    echo "Updating MAJOR version to $ARG_MAJOR..."
    MAJOR=$ARG_MAJOR
    CURRENT_MAJOR=$ARG_MAJOR
    CURRENT_MINOR="0"
    WORKING_VERSION_DEV_NUMBER="1"
    WORKING_VERSION="$CURRENT_MAJOR.$CURRENT_MINOR.0"
else
    # Increment the minor version and reset the dev number
    CURRENT_MINOR=$((CURRENT_MINOR + 1))
    WORKING_VERSION="$CURRENT_MAJOR.$CURRENT_MINOR.0"
    WORKING_VERSION_DEV_NUMBER="1"
fi

# Update the VERSION file with the new values
write_key_value "$VERSION_FILE" "MAJOR" "$MAJOR"
write_key_value "$VERSION_FILE" "WORKING_VERSION" "$WORKING_VERSION"
write_key_value "$VERSION_FILE" "WORKING_VERSION_DEV_NUMBER" "$WORKING_VERSION_DEV_NUMBER"

# Display updated version information
echo "MAJOR=$MAJOR"
echo "WORKING_VERSION=$WORKING_VERSION"
echo "WORKING_VERSION_DEV_NUMBER=$WORKING_VERSION_DEV_NUMBER"