{ config, pkgs, ... }:

{
  # Enable Unfree Packages
  nixpkgs.config.allowUnfree = true;

  # Modules
  imports = [
    # Applications
    # ./modules/neovim.nix
    # ./modules/gaming.nix
    # ./modules/wol.nix
    
    # Display managers
    # ./modules/dwl.nix
    # ./modules/hyprland.nix

  ];

  # User Identity
  home.username = "dylan";
  home.homeDirectory = "/home/dylan";

  # Version
  home.stateVersion = "25.05";

  # Packages
  home.packages = with pkgs; [
    brave
    trash-cli
    sway-audio-idle-inhibit


  ];

  # Self-Management
  programs.home-manager.enable = true;

  home.file = {
    #
  };





}
