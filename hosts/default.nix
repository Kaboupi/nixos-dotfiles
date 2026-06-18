{ config, pkgs, cfg, ... }:

{
  imports = [
    ./hardware.nix
    ../modules/system/core.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = cfg.hostname;

  users.users.${cfg.username} = {
    isNormalUser = true;
    description = cfg.username;
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.getty.autologinUser = cfg.username;

  environment.systemPackages = with pkgs; [
    curl
    foot
    git
    github-cli
    hyprpaper
    kitty
    nvim
    vim
    waybar
    wget
    wofi
  ];

  system.stateVersion = cfg.stateVersion;
}
