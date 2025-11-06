{ config, pkgs, ... }:

let
    dotfiles = "${config.home.homeDirectory}/dotfiles-master/config";
    create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;
    configs = {
      backgrounds = "backgrounds";
      fastfetch = "fastfetch"; 
      hypridle = "hypridle";
      hyprland = "hyprland";
      hyprlock = "hyprlock";
      hyprmocha = "hyprmocha";
      hyprpaper = "hyprpaper";
      kity = "kitty";
      mpv = "mpv";
      nvim = "nvim";
      starship = "starship";
      swaync = "swaync";
      waybar = "waybar";
      wofi = "wofi";
      zshrc = "zshrc";
      tmux = "tmux";
    };
in

{
  # Settings
  nixpkgs.config.allowUnfree = true;
  home.username = "dylan";
  home.homeDirectory = "/home/dylan";
  programs.git.enable = true;
  home.stateVersion = "25.05";

  # Packages
  home.packages = with pkgs; [
    brave
    trash-cli
    sway-audio-idle-inhibit
  ];

  # Symlink dotfiles
  xdg.configFile = builtins.mapAttrs (name: subpath: {
    source = create_symlink "${dotfiles}/${subpath}";
    recursive = true;
    force = true;
  })
  configs;
  

  # Self-Management
  programs.home-manager.enable = true;


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




}
