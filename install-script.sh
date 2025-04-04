#!/bin/bash

# Enable error checking for all commands
set -e

# Install paru if not already installed
if ! command -v paru &> /dev/null; then
    echo "Installing paru..."
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git /tmp/paru
    (cd /tmp/paru && makepkg -si --noconfirm)
    rm -rf /tmp/paru
fi

# Update the system and install pacman packages
echo "Updating system..."
sudo pacman -Syu --noconfirm

# List of pacman packages 
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
  nautilus
  swaync
  xdg-desktop-portal-gtk
  xdg-desktop-portal-hyprland
  hyprpolkitagent
  wlsunset
  zoxide
  zsh
  zsh-syntax-highlighting
  zsh-autosuggestions
  fzf
  qt6ct
  btop
  dbus
  stow
  flatpak
  ttf-cascadia-code
  ttf-ubuntu-font-family
  ttf-font-awesome
  pavucontrol
  ripgrep
  mpv
  fastfetch
  linux-headers
  linux-zen
  linux-zen-headers
  libva-nvidia-driver
  nvidia-dkms
  wl-clipboard
)

echo "Installing pacman packages..."
sudo pacman -S --needed --noconfirm "${pacman_packages[@]}"

# List of AUR packages
aur_packages=(
  trash-cli
  adwaita-dark
  hyprshot
  sway-audio-idle-inhibit-git
  brave-bin
)

echo "Installing AUR packages..."
paru -S --needed --noconfirm "${aur_packages[@]}"

# Set zsh as the default shell
echo "Setting zsh as the default shell..."
chsh -s "$(which zsh)"

echo "Installation complete!"
