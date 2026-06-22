{ cfg, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules
    ../../users
  ];

  system.stateVersion = cfg.stateVersion;
}
