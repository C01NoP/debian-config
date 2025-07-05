#!/bin/bash
set -e

# 1. Install sudo
apt update
apt install -y sudo

# 2. Add user 'mike' to sudo
if id -u mike &>/dev/null; then
  usermod -aG sudo mike
else
  echo "User 'mike' does not exist. Please create user 'mike' first."
  exit 1
fi

# 3. Install git
apt install -y git

# 4. Call debsetup.sh in the existing repo
DEB_SETUP="/home/mike/Git/debian-config/debsetup.sh"
if [ -f "$DEB_SETUP" ]; then
  chmod +x "$DEB_SETUP"
  echo "Running debsetup.sh..."
  sudo -u mike "$DEB_SETUP"
else
  echo "Error: $DEB_SETUP not found."
  exit 1
fi

# Note: `debsetup.sh` will do the remaining configuration and reboot.
