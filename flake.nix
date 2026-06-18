{
  description = "Hyprland on NixOS";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
    };
  };

  outputs = { nixpkgs, home-manager, ... }: {
    nixosConfigurations.kaboupi-hyprland = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager {
          home-manager = {
            useGlobalPkgs = true;	
            useUserPackages = true;	
            users.kabuoupi = true;	
            backupFileExtension = "bckp";	
          };
        };
      ];
    };
  };
}
