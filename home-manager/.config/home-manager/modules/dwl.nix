{ config, pkgs, ... }:

{
  # Packages
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
