#!/bin/bash

# Ensure running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Step 18: Comment out bookworm-backports lines in /etc/apt/sources.list
sed -i '/bookworm-backports/s/^/#/' /etc/apt/sources.list

# Step 19: Change Debian sources to sid and comment out stable/security repos
sed -i -E 's|(^deb\s+http[^ ]+)(\s+)(main)|# \1 sid \3|' /etc/apt/sources.list
sed -i -E 's|(^deb\s+http[^ ]+)(\s+)(main)|# \1 sid \3|' /etc/apt/sources.list
sed -i -E 's|(^deb\s+http[^ ]+)(\s+)(main)|# \1 sid-security \3|' /etc/apt/sources.list

# Step 19 (continued): update and upgrade
apt update
apt -y upgrade

# Step 20: Add fish to bottom of ~/.bashrc
echo "fish" >> /home/mike/.bashrc

# Step 21: Copy config.fish from git repo to ~/.config/fish
mkdir -p /home/mike/.config/fish
cp /home/mike/Git/debian-config/config.fish /home/mike/.config/fish/
chown -R mike:mike /home/mike/.config/fish

# Step 22: Reboot
echo "System updated to sid. Rebooting now..."
reboot
