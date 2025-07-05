#!/bin/bash
set -e

# Ensure running as root
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit 1
fi

REPO_URL="https://github.com/C01NoP/debian-config.git"
TARGET_DIR="/home/mike/Git"

# Check if git is installed
if ! command -v git &>/dev/null; then
  echo "git not found, installing..."
  apt update
  apt install -y git
fi

# Clone the repo if not already cloned
if [ ! -d "$TARGET_DIR" ]; then
  echo "Cloning repository..."
  git clone "$REPO_URL" "$TARGET_DIR"
else
  echo "Repository already cloned at $TARGET_DIR"
fi

# Note: 'debinit.sh' will do the rest, including a reboot.

