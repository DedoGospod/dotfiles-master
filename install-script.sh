#!/bin/bash

# Enable error checking for all commands
set -e

# Update the system and install pacman packages
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install paru if not already installed
if ! command -v paru &> /dev/null; then
    echo "Installing paru..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm)
    rm -rf /tmp/paru
fi

# Refresh package databases (critical for fresh paru installs)
sudo pacman -Sy

# List of pacman packages (your original list)
pacman_packages=(
  hyprland
  kitty
  hypridle
  hyprlock
  hyprpaper
  neovim
  starship
  waybar
  wofi
  yazi
  zsh
  nautilus
  swaync
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  hyprpolkitagent
  wlsunset
  zoxide
  zsh-syntax-highlighting
  fzf
  qt6ct
  btop
  dbus
  stow
)

echo "Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${pacman_packages[@]}"

# List of AUR packages (your original list)
aur_packages=(
  trash-cli
  adwaita-dark
  hyprshot
)

echo "Installing AUR packages..."
paru -S --needed --noconfirm "${aur_packages[@]}"

# Set zsh as the default shell
echo "Setting zsh as the default shell..."
chsh -s "$(which zsh)"

echo "Installation complete!"
