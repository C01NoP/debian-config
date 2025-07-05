#!/bin/bash

# Step 1: Backup the current sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Step 2: Replace deb and deb-src lines with the specified lines
sudo sed -i \
  -e 's|^deb .*|deb http://deb.debian.org/debian/ sid main contrib non-free-firmware non-free|' \
  -e 's|^deb-src .*|deb-src http://deb.debian.org/debian/ sid main contrib non-free non-free-firmware|' \
 /etc/apt/sources.list

# Step 3: Comment out lines that are not the desired ones
sudo sed -i -E '
  /^#/! {
    /deb http:\/\/deb.debian.org\/debian\/ sid main contrib non-free-firmware non-free/! s/^/# /
  }
' /etc/apt/sources.list

# Step 4: Update package lists and upgrade
sudo apt update && sudo apt upgrade -y

# Step 5: Add 'fish' to the bottom of ~/.bashrc
echo 'exec fish' >> ~/.bashrc

# Step 6: Copy config.fish from source to ~/.config/fish/
mkdir -p ~/.config/fish
cp /home/mike/Git/debian-config/config.fish ~/.config/fish/

# Step 7: Source the fish config
source ~/.config/fish/config.fish

# Step 8: Source the kitty config
cp /home/mike/Git/debian-config/kitty.conf ~/.config/kitty/

# Step 8: Remove unnecessary packages and clean cache
sudo apt autoremove -y
sudo apt clean
