#!/bin/bash

# Step 18: Change /etc/apt/sources.list to point to sid instead of bookworm
sudo sed -i 's|/bookworm|/sid|g' /etc/apt/sources.list

# Step 19: Comment out lines that do NOT contain 'sid'
sudo awk 'NR <= 5 {print; next} {if ($0 ~ /sid/) {print} else {print "#" $0}}' /etc/apt/sources.list | sudo tee /etc/apt/sources.list.new
sudo mv /etc/apt/sources.list.new /etc/apt/sources.list

# Run update and upgrade
sudo apt update && sudo apt upgrade -y

# Step 20: Add 'fish' to the bottom of ~/.bashrc
echo "fish" >> ~/.bashrc

# Step 21: Copy config.fish from /home/mike/Git/debian-config to ~/.config/fish/
mkdir -p ~/.config/fish
cp /home/mike/Git/debian-config/config.fish ~/.config/fish/

# Step 22: Run autoremove and clean all
sudo apt autoremove -y
sudo apt clean
