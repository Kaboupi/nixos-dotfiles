let
  installationDir = "/etc/nixos";
in {
  username = "kaboupi";
  hostname = "nixos-homelab";

  timezone = "Europe/Moscow";
  locale = "en_US.UTF-8";

  defaultEditor = "nvim";

  # SSH
  # NOTE: Port 22 is widely used across SSH conenctions.
  # Change it to any other usable port (ex. 18231, 22222)
  sshPort = 22;

  # NOTE: Change it to `false` after initial setup
  # and switch to SSH keys instead: ./users/default.nix
  sshPasswordAuthentication = true;

  # NOTE: Add keys after initial setup
  sshAuthorizedKeys = [];

  # PORTS
  allowedTCPPorts = [];
  allowedUDPPorts = [];

  # PACKAGES
  userPackages = [
    "eza"
    "fastfetch"
    "lsd"
    "obs-studio"
    "telegram-desktop"
    "spotify"
  ];

  extraPackages = [];

  # PACKAGE FLAGS
  pkgsOptions = {
    hyprland = {
      install = true;
      mainMod = "SUPER";
    };
    caelestia = { install = true; };
    kitty = { install = true; };
    yazi = { install = true; };
  };

  # ALIASES
  shellAliases = {
    ff = "fastfetch";
    la = "lsd -a -1 --color=auto";
    ll = "lsd -l --color=auto";
    lla = "lsd -l -a -1 --color=auto";
    ls = "lsd --color=auto";
    n = "nvim";
    update = "sudo nixos-rebuild switch --flake ${installationDir}";
  };

  devShells = {
    py3 = "nix-shell ${installationDir}/shells/py3.nix";
  };

  # NOTE: It's not recommended to change this variable.
  # Change at your own risk.
  stateVersion = "26.05";
}
