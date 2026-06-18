{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/system/core.nix
  ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "kaboupi-nixos";

  users.users.kaboupi = {
    isNormalUser = true;
    description = "kaboupi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.getty.autologinUser = "kaboupi";

  environment.systemPackages = with pkgs; [
    curl
    foot
    git
    github-cli
    hyprpaper
    kitty
    vim
    waybar
    wget
    wofi
  ];

  system.stateVersion = "26.05"; 
}
