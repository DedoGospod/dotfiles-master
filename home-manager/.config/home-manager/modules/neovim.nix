{ config, pkgs, ... }:

{
  # 1. Packages
  home.packages = with pkgs; [
    neovim
    nodejs # should include npm
    unzip
    clang
    go
    shellcheck
    zig
    luarocks-nix 
    dotnet-sdk
    cmake
    # gcc
    imagemagick
  ];

}
