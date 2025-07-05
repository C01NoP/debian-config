#!/bin/bash
set -e

# 6. Install packages
apt update
apt install -y gnome-shell gnome-tweaks nautilus vim fish firefox kitty vlc crispy-doom dsda-doom gnome-calculator loupe timeshift deja-dup flatpak nvidia-driver

# 7. Enable flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 8. Change sources to bookworm-backports
cat <<EOF > /etc/apt/sources.list.d/debian.sources
Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: bookworm-backports
Components: main
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF

# 9. Install kernel from buster-backports
apt install -t buster-backports linux-image-amd64 linux-headers-amd64 -y

# 10. Disable backports
sed -i 's/Enabled: yes/Enabled: no/' /etc/apt/sources.list.d/debian.sources

# 11. Switch to sid
cat <<EOF > /etc/apt/sources.list.d/debian.sources
Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: sid
Components: main contrib non-free non-free-firmware
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF

# 12. Update and upgrade
apt update
apt upgrade -y

# 13. Add fish to ~/.bashrc (for user mike)
echo "Adding fish shell to ~/.bashrc..."
echo "exec fish" >> /home/mike/.bashrc

# 14. Copy config.fish from the repo to ~/.config/fish/
mkdir -p /home/mike/.config/fish
cp /home/mike/Git/debian-config/config.fish /home/mike/.config/fish/

# 15. Reboot
echo "Setup complete. Rebooting..."
reboot
