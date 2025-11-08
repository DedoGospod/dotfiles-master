outputs = { self, nixpkgs, home-manager, ... }: {
  # Define a home-manager configuration for your user "tony"
  homeConfigurations.tony = home-manager.lib.homeManagerConfiguration {
    pkgs = nixpkgs.legacyPackages.x86_64-linux; # Or whatever system you target
    modules = [
      # The home.nix file you were importing
      ./home-manager/home.nix
      {
        home.username = "dylan";
        home.homeDirectory = "/home/dylan"
        home.stateVersion = "24.05";
      }
    ];
  };
};
