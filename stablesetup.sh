#!/bin/bash

set -e

# 1. Install sudo as root (assuming script runs as root)
apt update
apt install -y sudo

# 2. Grant user 'mike' sudo access
usermod -aG sudo mike

# 3. Install git, wget, vim
apt install -y git wget vim

# 4. Update /etc/apt/sources.list to include contrib and non-free
sed -i '/^deb / s/$/ contrib non-free/' /etc/apt/sources.list
sed -i '/^deb-src / s/$/ contrib non-free/' /etc/apt/sources.list

# 5. Add 32-bit architecture
dpkg --add-architecture i386

# 6. Add the DRD repo key
wget -O /etc/apt/trusted.gpg.d/drdteam.gpg https://debian.drdteam.org/drdteam.gpg

# 7. Add DRD repo to sources.list
echo "deb https://debian.drdteam.org/ stable multiverse" | tee -a /etc/apt/sources.list

# Update package lists
apt update

# 8. Install packages
apt install -y gnome-shell gnome-tweaks nautilus vim fish steam-installer \
 mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 \
 libgl1-mesa-dri:i386 kitty vlc crispy-doom dsda-doom gzdoom gnome-calculator \
 timeshift deja-dup flatpak ffmpegthumbnailer curl dkms linux-headers-amd64 apt-listbugs \
 firefox-esr

# 9. Activate Flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 10. Clone Tela-icon-theme repo
sudo -u mike git clone https://github.com/vinceliuice/Tela-icon-theme.git /home/mike/Git/Tela-icon-theme

# 11. Run install.sh in Tela-icon-theme
sudo -u mike bash /home/mike/Git/Tela-icon-theme/install.sh

# 12. Clone Orchis-theme repo
sudo -u mike git clone https://github.com/vinceliuice/Orchis-theme.git /home/mike/Git/Orchis-theme

# 13. Run install.sh in Orchis-theme
sudo -u mike bash /home/mike/Git/Orchis-theme/install.sh

# 14. Clone Qogir-icon-theme repo
sudo -u mike git clone https://github.com/vinceliuice/Qogir-icon-theme.git /home/mike/Git/Qogir-icon-theme

# 15. Run install.sh in Qogir-icon-theme
sudo -u mike bash /home/mike/Git/Qogir-icon-theme/install.sh

# 16. Install Fisher
sudo -u mike bash -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"

# 17. Install bobthefish theme
# To run fish commands, ensure fish shell is installed and set as default or run via fish -c
apt install -y fish
sudo -u mike fish -c "fisher install oh-my-fish/theme-bobthefish"

echo "Setup completed successfully!"
