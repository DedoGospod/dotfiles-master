{
  description = "Dylan's Home Manager Flake (Standalone)";

inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

outputs = { self, nixpkgs, home-manager, ... }: {
  homeConfigurations.dylan = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux; # Or whatever system you target
    modules = [
      ./home-manager/.config/home-manager/home.nix
      {
        home.username = "dylan";
        home.homeDirectory = "/home/dylan";
        home.stateVersion = "25.05";
      }
    ];
  };
};

}
