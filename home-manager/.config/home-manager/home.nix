{ config, pkgs, ... }:

{
  imports = [
    # ./modules/hyprland.nix
    # ./modules/neovim.nix
  ];

  # 1. User Identity
  home.username = "dylan";
  home.homeDirectory = "/home/dylan";

  # 2. State Version
  home.stateVersion = "25.05";

  # 3. Packages (Activated Feature)
  home.packages = with pkgs; [
    brave
    trash-cli
    sway-audio-idle-inhibit

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # 4. Self-Management
  programs.home-manager.enable = true;
}
