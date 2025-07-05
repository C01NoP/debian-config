#!/bin/bash

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

# Step 18: Download the NVIDIA GPG key and add it
curl -fSsL https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/3bf863cc.pub | gpg --dearmor | tee /usr/share/keyrings/nvidia-drivers.gpg > /dev/null 2>&1

# Step 19: Add the NVIDIA CUDA repository
echo 'deb [signed-by=/usr/share/keyrings/nvidia-drivers.gpg] https://developer.download.nvidia.com/compute/cuda/repos/debian12/x86_64/ /' | tee /etc/apt/sources.list.d/nvidia-drivers.list

# Update package list
apt update

# Step 20: Install the NVIDIA driver
apt install -y nvidia-driver

# Step 21: Rebuild kernel modules if needed
# Usually, installing the driver takes care of module building.
# To force rebuild or ensure modules are loaded:
nvidia-modprobe --update || true

# Step 22: Reboot the system
echo "NVIDIA driver installation complete. Rebooting now..."
reboot
