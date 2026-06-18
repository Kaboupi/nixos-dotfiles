# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;
  boot.loader.grub.fsIdentifier = "provided";

  # Enables wireless support via wpa_supplicant.
  networking.wireless.enable = true;  

  # Enable networking
  networking.hostName = "kaboupi-nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Moscow";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

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

  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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

  # Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    # withUWSM = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

#  hardware = {
#    graphics.enable = true;
#  };

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  networking.firewall.enable = false;

  system.stateVersion = "26.05"; 

  # Post-init-like scripts
  system.activationScripts.setupVMEssentials = {
    text = ''
      TARGET_USER="kaboupi"
      USER_HOME="/home/$TARGET_USER"

      REPO_NAME="vm-essentials"
      REPO_DIR="$USER_HOME/$REPO_NAME"
      REPO_URL="git@github.com:Kaboupi/$REPO_NAME.git"

      if [ -d "$USER_HOME" ]; then
        echo "|-- Sync vm-essentials repo"

        if [ -d "$REPO_DIR" ]; then
          echo "|   `-- $REPO_DIR exists, pulling..."
          cd "$REPO_DIR"
          ${pkgs.git}/bin/git pull
        else
          echo "|   `-- $REPO_DIR does not exist, cloning..."
          ${pkgs.git}/bin/git clone $REPO_URL
        fi

        echo "`-- Setup for user"

        ln -sf "$REPO_DIR/dotfiles/.vimrc" "$USER_HOME/.vimrc"
        ln -sf "$REPO_DIR/dotfiles/.bash_aliases" "$USER_HOME/.bash_aliases"

        chown -R $USER_NAME:users "$REPO_DIR"
        chown -h $USER_NAME:users "$USER_HOME/.vimrc"

        echo "`-- Setup for root"
        mkdir -p /root/.config

        ln -sf "$REPO_DIR/dotfiles/.vimrc" "/root/.vimrc"
        chown -h root:root "/root/.vimrc"

      fi
    '';
  };
}
