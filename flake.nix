{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      cfg = import ./config.nix;

      mkHost = hostname: nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit cfg; };
        modules = [
          ./hosts/${hostname}/default.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit cfg; };
              users.${cfg.username} = import ./users/home.nix;
              backupFileExtension = "bckp";
            };
          }
        ];
      };
    in
    {
      nixosConfigurations.${cfg.hostname} = mkHost "desktop";
    };
}
