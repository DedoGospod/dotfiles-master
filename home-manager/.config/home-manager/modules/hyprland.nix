{ config, pkgs, ... }:

{
  # 1. Packages
  home.packages = with pkgs; [
    kitty
    uwsm
    hyprland
    hyprlock
    hyprpaper
    hyprshot
    neovim
    starship
    waybar
    wofi
    yazi
    swaynotificationcenter
    xdg-desktop-portal
    xdg-desktop-portal-gtk
    xdg-desktop-portal-hyprland
    hyprpolkitagent
    hyprland-qtutils
    hyprutils
    wlsunset
    zoxide
    zsh
    zsh-completions
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf
    nwg-look
    btop
    dbus
    stow
    flatpak
    pavucontrol
    ripgrep
    nwg-look
    btop
    dbus
    stow
    flatpak
    ripgrep
    mpv
    fastfetch
    ncdu
    networkmanager
    timeshift
    cronie
    pipewire
    wireplumber
    bat
    man
    tlp
    tmux
    gnome-disk-utility
    gnome-themes-extra
    gnome-keyring

  ];

}
