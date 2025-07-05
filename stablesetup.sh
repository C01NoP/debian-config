#!/bin/bash

# Install required packages
apt update
apt install -y gnome-shell gnome-tweaks nautilus vim fish steam kitty vlc crispy-doom dsda-doom gnome-calculator timeshift deja-dup flatpak ffmpegthumbnailer curl wget dkms linux-headers-amd64

# 8. Activate Flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 9. Clone Tela-icon-theme
git clone https://github.com/vinceliuice/Tela-icon-theme.git "$HOME_DIR/Git/Tela-icon-theme"

# 10. Run install.sh in Tela-icon-theme
bash "$HOME_DIR/Git/Tela-icon-theme/install.sh"

# 11. Clone Orchis-theme
git clone https://github.com/vinceliuice/Orchis-theme.git "$HOME_DIR/Git/Orchis-theme"
bash "$HOME_DIR/Git/Orchis-theme/install.sh"

# 13. Clone Qogir-icon-theme
git clone https://github.com/vinceliuice/Qogir-icon-theme.git "$HOME_DIR/Git/Qogir-icon-theme"
bash "$HOME_DIR/Git/Qogir-icon-theme/install.sh"

# 15. Install Fisher
su - "$USER" -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher'

# 16. Install bobthefish theme
su - "$USER" -c 'fish -c "fisher install oh-my-fish/theme-bobthefish"'

# 17. Move fish.config from /root/Git/debian-config to /home/mike/.config
mkdir -p "$HOME_DIR/.config"
mv "/root/Git/debian-config/fish.config" "$HOME_DIR/.config/"

# 18. Move kitty.config from /root/Git/debian-config to /home/mike/.config/kitty
mkdir -p "$HOME_DIR/.config/kitty"
mv "/root/Git/debian-config/kitty.config" "$HOME_DIR/.config/kitty/"

# 19. Copy entire /root/Git to /home/mike/Git
rm -rf "$GIT_DIR"
cp -r "/root/Git" "$GIT_DIR"
chown -R "$USER":"$(id -gn $USER)" "$GIT_DIR"

# End of debian-config/stablesetup.sh
