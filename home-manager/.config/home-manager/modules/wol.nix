{ config, pkgs, ... }:

{
  # 1. Packages
  home.packages = with pkgs; [
    wol
    ethtool
  ];

}
