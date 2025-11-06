{ config, pkgs, ... }:

{
  # 1. Packages
  home.packages = with pkgs; [
    dwl
    libinput
    wlroots
    wayland
    wayland-protocols
    pkg-config
    libxkbcommon
  ];

}
