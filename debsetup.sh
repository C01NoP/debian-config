#!/bin/bash

# debsetup - Automated Debian setup script

set -e

echo "Starting debsetup..."

# 1. Install sudo if not present
if ! command -v sudo &>/dev/null; then
    echo "Installing sudo..."
    apt update
    apt install -y sudo
fi

# 2. Add user 'mike' to sudo group
if id -u mike &>/dev/null; then
    echo "Adding user 'mike' to sudo group..."
    usermod -aG sudo mike
else
    echo "User 'mike' does not exist. Please create the user before running this script."
    exit 1
fi

# 3. Install packages
PACKAGES=(
  gnome-shell
  gnome-tweaks
  nautilus
  git
  vim
  fish
  firefox
  kitty
  vlc
  crispy-doom
  dsda-doom
  gnome-calculator
  loupe
  timeshift
  deja-dup
  flatpak
  nvidia-driver
)

echo "Updating package list..."
apt update

echo "Installing packages..."
apt install -y "${PACKAGES[@]}"

# 4. Activate Flatpak
echo "Adding Flathub remote..."
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 5. Configure /etc/apt/sources.list.d/debian.sources
SOURCE_FILE="/etc/apt/sources.list.d/debian.sources"

echo "Writing to $SOURCE_FILE..."
cat <<EOF > "$SOURCE_FILE"
Types: deb deb-src
URIs: http://deb.debian.org/debian
Suites: bookworm-backports
Components: main
Enabled: yes
Signed-By: /usr/share/keyrings/debian-archive-keyring.gpg
EOF

# Update package list after changing sources
apt update

# 6. Install Linux kernel from backports
echo "Installing Linux kernel and headers from buster-backports..."
apt install -t buster-backports linux-image-amd64 linux-headers-amd64 -y

# 7. Disable the backports entry
echo "Disabling backports in $SOURCE_FILE..."
sed -i 's/Enabled: yes/Enabled: no/' "$SOURCE_FILE"

# 8. Reboot prompt
read -p "Setup complete. Reboot now? (yes/no): " REBOOT_ANSWER
if [[ "$REBOOT_ANSWER" =~ ^[Yy][Ee][Ss]|[Yy]$ ]]; then
    echo "Rebooting..."
    reboot
else
    echo "Please reboot manually to complete the setup."
fi
