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

# Step 4: Create directory /home/mike/Git
mkdir -p /home/mike/Git
chown mike:mike /home/mike/Git

# Step 5: Clone your main repo
sudo -u mike git clone https://github.com/C01NoP/debian-config.git /home/mike/Git/debian-config

# Step 6: Make stablesetup.sh executable and run it
sudo -u mike chmod +x /home/mike/Git/debian-config/stablesetup.sh
sudo -u mike /home/mike/Git/debian-config/stablesetup.sh
