#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# 1. Install sudo as root
apt update
apt install -y sudo git vim

# 2. Grant user 'mike' sudo access
usermod -aG sudo mike

# 3. Update /etc/apt/sources.list to include non-free repository
# Backup original sources.list
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# Add non-free to existing repositories
sed -i '/^deb / s/$/ non-free/' /etc/apt/sources.list

apt update

# 4. Install packages via apt
apt install -y gnome-shell gnome-tweaks nautilus vim fish steam kitty vlc crispy-doom dsda-doom gnome-calculator timeshift deja-dup flatpak ffmpegthumbnailer curl wget dkms linux-headers-amd64

# 5. Activate flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 6. Clone and install Tela-icon-theme
sudo -u mike bash -c '
mkdir -p /home/mike/Git
cd /home/mike/Git
git clone https://github.com/vinceliuice/Tela-icon-theme.git
cd Tela-icon-theme
./install.sh
'

# 7. Clone and install Orchis-theme
sudo -u mike bash -c '
cd /home/mike/Git
git clone https://github.com/vinceliuice/Orchis-theme.git
cd Orchis-theme
./install.sh
'

# 8. Clone and install Qogir-icon-theme
sudo -u mike bash -c '
cd /home/mike/Git
git clone https://github.com/vinceliuice/Qogir-icon-theme.git
cd Qogir-icon-theme
./install.sh
'

# 9. Install Fisher
sudo -u mike fish -c '
curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source
fisher install jorgebucaran/fisher
'

# 10. Install bobthefish theme
sudo -u mike fish -c 'fisher install oh-my-fish/theme-bobthefish'

echo "Setup complete! Please reboot or relog to ensure all group changes take effect."
