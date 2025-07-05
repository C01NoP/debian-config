
#!/bin/bash
set -e

# 7. Install packages
apt update
apt install -y gnome-shell gnome-tweaks nautilus vim fish steam kitty vlc crispy-doom dsda-doom gnome-calculator timeshift deja-dup flatpak ffmpegthumbnailer curl wget dkms linux-headers-amd64

# 8. Activate flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 9-14. Clone themes and run their install.sh
mkdir -p "$HOME_DIR/Git"

git clone https://github.com/vinceliuice/Tela-icon-theme.git "$HOME_DIR/Git/Tela-icon-theme"
(cd "$HOME_DIR/Git/Tela-icon-theme" && ./install.sh)

git clone https://github.com/vinceliuice/Orchis-theme.git "$HOME_DIR/Git/Orchis-theme"
(cd "$HOME_DIR/Git/Orchis-theme" && ./install.sh)

git clone https://github.com/vinceliuice/Qogir-icon-theme.git "$HOME_DIR/Git/Qogir-icon-theme"
(cd "$HOME_DIR/Git/Qogir-icon-theme" && ./install.sh)

# 15. Move fish.config
if [ -f "$REPO_PATH/debian-config/fish.config" ]; then
    mkdir -p "$HOME_DIR/.config/fish"
    cp "$REPO_PATH/debian-config/fish.config" "$HOME_DIR/.config/fish/config.fish"
fi

# 16. Move kitty.config
if [ -f "$REPO_PATH/debian-config/kitty.config" ]; then
    mkdir -p "$HOME_DIR/.config/kitty"
    cp "$REPO_PATH/debian-config/kitty.config" "$HOME_DIR/.config/kitty/"
fi

# 17. Copy entire /root/Git to /home/mike/Git
# First, ensure /home/mike/Git exists
mkdir -p "$GIT_DIR"
# Remove existing to prevent conflicts
rm -rf "$GIT_DIR"
# Copy recursively
cp -r "$ROOT_HOME/Git" "$GIT_DIR"

# Change ownership to user
chown -R "$USER":"$USER" "$HOME_DIR"

# --- End of debian-config/stablesetup.sh ---
