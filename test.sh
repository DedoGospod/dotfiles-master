#!/bin/bash

# Better error handling
set -euo pipefail

# Function to install paru safely
install_paru() {
    echo "Installing paru..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm --skippgpcheck)
    rm -rf /tmp/paru
}

# Install paru if not already installed
if ! command -v paru &> /dev/null; then
    install_paru
fi

# Update the system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# List of pacman packages
pacman_packages=(
  hyprland
  kitty
  hypridle
  hyprlock
  # ... rest of your packages
)

# Install pacman packages with error handling
echo "Installing pacman packages..."
for pkg in "${pacman_packages[@]}"; do
    if ! sudo pacman -S --needed --noconfirm "$pkg"; then
        echo "Failed to install $pkg, continuing..."
    fi
done

# List of AUR packages
aur_packages=(
  trash-cli
  adwaita-dark
  # ... rest of your AUR packages
)

# Install AUR packages with error handling
echo "Installing AUR packages..."
for pkg in "${aur_packages[@]}"; do
    if ! paru -S --needed --noconfirm "$pkg"; then
        echo "Failed to install $pkg, continuing..."
    fi
done

# Set zsh as default shell
echo "Setting zsh as the default shell..."
if command -v zsh &> /dev/null; then
    chsh -s "$(which zsh)"
else
    echo "zsh not found, skipping shell change"
fi

echo "Installation complete!"
