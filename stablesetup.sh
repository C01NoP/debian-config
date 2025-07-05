#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# 1. Install sudo as root
apt update
apt install -y sudo

# 2. Grant user 'mike' sudo access
usermod -aG sudo mike

# 3. Install git, wget, vim
apt install -y git wget vim

# 4. Update /etc/apt/sources.list to include contrib and non-free repositories
sed -i '/^deb / s/$/ contrib non-free/' /etc/apt/sources.list
sed -i '/^deb-src / s/$/ contrib non-free/' /etc/apt/sources.list

# 5. Add 32-bit architecture
dpkg --add-architecture i386

# 6. Add DRD repo
wget -O /etc/apt/trusted.gpg.d/drdteam.gpg https://debian.drdteam.org/drdteam.gpg
add-apt-repository 'deb https://debian.drdteam.org/ stable multiverse'

# Update package lists
apt update

# 7. Install packages
apt install -y gnome-shell gnome-tweaks nautilus vim fish steam-installer \
mesa-vulkan-drivers libglx-mesa0:i386 mesa-vulkan-drivers:i386 libgl1-mesa-dri:i386 \
kitty vlc crispy-doom dsda-doom gzdoom gnome-calculator timeshift deja-dup flatpak \
ffmpegthumbnailer curl dkms linux-headers-amd64

# 8. Activate flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

# 9. Clone Tela-icon-theme repository and run install.sh
git clone https://github.com/vinceliuice/Tela-icon-theme.git /home/mike/Git/Tela-icon-theme
chown -R mike:mike /home/mike/Git/Tela-icon-theme
sudo -u mike bash -c "/home/mike/Git/Tela-icon-theme/install.sh"

# 10. Clone Orchis-theme repository and run install.sh
git clone https://github.com/vinceliuice/Orchis-theme.git /home/mike/Git/Orchis-theme
chown -R mike:mike /home/mike/Git/Orchis-theme
sudo -u mike bash -c "/home/mike/Git/Orchis-theme/install.sh"

# 11. Clone Qogir-icon-theme repository and run install.sh
git clone https://github.com/vinceliuice/Qogir-icon-theme.git /home/mike/Git/Qogir-icon-theme
chown -R mike:mike /home/mike/Git/Qogir-icon-theme
sudo -u mike bash -c "/home/mike/Git/Qogir-icon-theme/install.sh"

# 12. Append 'fish' to ~/.bashrc
echo "fish" >> /home/mike/.bashrc
chown mike:mike /home/mike/.bashrc

# 13. Change default shell to fish for user 'mike'
chsh -s /usr/bin/fish mike

# 14. Install fisher and bobthefish theme in fish shell
sudo -u mike fish -c 'curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; and fisher install jorgebucaran/fisher'
sudo -u mike fish -c 'fisher install oh-my-fish/theme-bobthefish'

# 15. Create /var/lib/AccountsService/users/mike with specified content
cat <<EOF | sudo tee /var/lib/AccountsService/users/mike
[User]
Language=
XSession=gnome
SystemAccount=true
EOF

# Change ownership
sudo chown root:root /var/lib/AccountsService/users/mike

echo "Setup completed successfully."
