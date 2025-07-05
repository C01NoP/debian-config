#!/bin/bash

# Update package list
apt update

# Step 7: Install packages
apt install -y gnome-shell gnome-tweaks nautilus vim fish firefox kitty vlc crispy-doom dsda-doom gnome-calculator timeshift deja-dup flatpak ffmpegthumbnailer vlc

# Step 8: Activate Flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# Step 9: Clone Tela-icon-theme
git clone https://github.com/vinceliuice/Tela-icon-theme /home/mike/Git/Tela-icon-theme
# Run its install script
bash /home/mike/Git/Tela-icon-theme/install.sh

# Step 10: Clone Orchis-theme
git clone https://github.com/vinceliuice/Orchis-theme /home/mike/Git/Orchis-theme
bash /home/mike/Git/Orchis-theme/install.sh

# Step 11: Clone Qogir-icon-theme
git clone https://github.com/vinceliuice/Qogir-icon-theme /home/mike/Git/Qogir-icon-theme
bash /home/mike/Git/Qogir-icon-theme/install.sh

# Reboot after all operations
echo "All setup complete. Rebooting now..."
reboot
