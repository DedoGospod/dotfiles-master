{ config, pkgs, ... }:

{
  # 1. Packages
  home.packages = with pkgs; [
    gamemode
    gamescope
    mangohud
    steam
  ];

}
