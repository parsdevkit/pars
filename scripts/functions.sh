#!/bin/bash

# Function to read the key value from the VERSION file with a default value
read_key_value() {
    # Parameters:
    # $1 - file name
    # $2 - key
    # $3 - default value (optional)
    
    local file=$1
    local key=$2
    local default_value=$3
    
    # Check if the file exists
    if [ ! -f "$file" ]; then
        echo "$default_value"
        return
    fi
    
    # Extract the value for the key from the file
    local value=$(grep "^$key=" "$file" | cut -d'=' -f2)
    
    # If the value is empty or not found, return the default value
    if [ -z "$value" ]; then
        echo "$default_value"
    else
        echo "$value"
    fi
}

# Function to write or update the key value in the VERSION file
write_key_value() {
    if grep -q "^$2=" "$1"; then
        sed -i "s/^$2=.*/$2=$3/" "$1"
    else
        echo "$2=$3" >> "$1"
    fi
}

# Function to delete a key from the VERSION file
delete_key() {
    if grep -q "^$2=" "$1"; then
        sed -i "/^$2=/d" "$1"
    else
        echo "Error: Key $2 does not exist in the VERSION file."
    fi
}
