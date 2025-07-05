#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Step 13: Add bookworm-backports to /etc/apt/sources.list
echo "deb http://deb.debian.org/debian bookworm-backports main" | tee -a /etc/apt/sources.list

# Update package list
apt update

# Step 15: Install kernel image and headers from backports
apt -t bookworm-backports install -y linux-image-amd64 linux-headers-amd64

# Ensure dkms is installed
apt install -y dkms

# Step 16: Rebuild kernel modules with DKMS
dkms autoinstall

# Step 17: Reboot the system
echo "Kernel upgrade complete. Rebooting now..."
reboot
