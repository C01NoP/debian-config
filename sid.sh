#!/bin/bash

# Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root."
  exit 1
fi

# Backup the original sources list
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Modify /etc/apt/sources.list
sed -i.bak '
/^deb / s|^deb .*|deb http://deb.debian.org/debian/ sid main contrib non-free-firmware non-free|
/^deb-src / s|^deb-src .*|deb-src http://deb.debian.org/debian/ sid main contrib non-free non-free-firmware|
! /^deb / ! /^deb-src / s/^/# /' /etc/apt/sources.list

echo "Updated /etc/apt/sources.list with Debian Sid repositories and commented out other lines."

# Update repositories and upgrade
apt update
apt full-upgrade -y

# Remove unnecessary packages and clean cache
apt autoremove -y
apt clean

# Reboot the system
echo "Rebooting the system..."
reboot
