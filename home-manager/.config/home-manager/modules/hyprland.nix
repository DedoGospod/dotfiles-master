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
    qadwaitadecorations
    zoxide
    zsh
    zsh-completions
    zsh-syntax-highlighting
    zsh-autosuggestions
    fzf
    kdePackages.qt6ct
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
    cascadia-code
    ubuntu-sans
    font-awesome
    ripgrep
    mpv
    ffmpeg-full
    # ffmpegthumbnailer-unstable
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
    bluez
    bluez-tools
    gnome-disk-utility
    gnome-themes-extra
    gnome-keyring
    # obsidian
  ];

}
