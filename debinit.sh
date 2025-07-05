#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Step 1: Install sudo
apt update
apt install -y sudo

# Step 2: Add user 'mike' to sudo group
usermod -aG sudo mike

# Step 3: Install git
apt install -y git
