#!/bin/bash

# Function to read the key value from the VERSION file
read_key_value() {
    grep "^$2=" "$1" | cut -d'=' -f2
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
