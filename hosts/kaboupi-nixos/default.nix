# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware.nix
      ../../modules/system/core.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
#  boot.loader.grub.enable = true;
#  boot.loader.grub.device = "/dev/sda";
#  boot.loader.grub.useOSProber = true;
#  boot.loader.grub.fsIdentifier = "provided";

  # Enable networking
  networking.hostName = "kaboupi-nixos";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.kaboupi = {
    isNormalUser = true;
    description = "kaboupi";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      tree
    ];
  };

  services.getty.autologinUser = "kaboupi";

  # List packages installed in system profile. To search, run:
  environment.systemPackages = with pkgs; [
    foot
    hyprpaper
    waybar
    curl
    git
    github-cli
    kitty
    vim
    wget
    wofi
  ];

  system.stateVersion = "26.05"; 
}
