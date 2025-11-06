{ config, pkgs, ... }:

{
  # Modules
  imports = [
    # Nvidia support
    # ./modules/nvidia.nix # BROKEN

    # Applications
    # ./modules/neovim.nix
    # ./modules/gaming.nix
    # ./modules/wol.nix
    
    # Display managers
    # ./modules/dwl.nix
    # ./modules/hyprland.nix

  ];
  # Settings
  nixpkgs.config.allowUnfree = true;
  home.username = "dylan";
  home.homeDirectory = "/home/dylan";
  home.stateVersion = "25.05";

  # Packages
  home.packages = with pkgs; [
    brave
    trash-cli
    sway-audio-idle-inhibit
  ];

  # Self-Management
  programs.home-manager.enable = true;

}
