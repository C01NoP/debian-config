#!/bin/bash

set -e

# Make sure to run as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root (e.g., sudo $0)"
  exit 1
fi

# 1. Change /etc/apt/sources.list to point to sid
sed -i 's/bookworm/sid/g' /etc/apt/sources.list

# 2. Comment out all lines except the first two
awk 'NR<=2 {print; next} {print "#" $0}' /etc/apt/sources.list > /etc/apt/sources.list.tmp
mv /etc/apt/sources.list.tmp /etc/apt/sources.list

# 3. Update and upgrade
apt update
apt upgrade -y

# 4. Add 'fish' to the bottom of ~/.bashrc for user 'mike'
echo "fish" >> /home/mike/.bashrc

# 5. Copy config.fish from /home/mike/Git/debian-config to ~/.config/fish/
# Ensure the target directory exists
mkdir -p /home/mike/.config/fish
cp /home/mike/Git/debian-config/config.fish /home/mike/.config/fish/

# Change ownership to 'mike'
chown -R mike:mike /home/mike/.config/fish
chown mike:mike /home/mike/.bashrc

# 6. Run autoremove and clean
apt autoremove -y
apt clean

# 7. Reboot
echo "All done. Rebooting now..."
reboot
