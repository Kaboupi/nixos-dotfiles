{
  description = "NixOS Dotfiles";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }:
    let
      cfg = import ./config.nix;
    in
    {
      nixosConfigurations.${cfg.hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit cfg; };
        modules = [
          ./hosts/default.nix
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.${cfg.username} = import ./home/home.nix;
              backupFileExtension = "bckp";
            };
          }
        ];
      };
    };
}
