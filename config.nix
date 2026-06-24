{
  username = "kaboupi";
  hostname = "nixos-homelab";

  timezone = "Europe/Moscow";
  locale = "en_US.UTF-8";

  # NOTE: Port 22 is widely used across SSH conenctions.
  # Change it to any other usable port (ex. 18231, 22222)
  sshPorts = [ 22 ];

  # NOTE: Change it to `false` after initial setup
  # and switch to SSH keys instead: ./users/default.nix
  sshPasswordAuthentication = true;

  extraPackages = [
  ];

  userPackages = [
    "fastfetch"
    "lsd"
    "obs-studio"
    "telegram-desktop"
  ];

  shellAliases = {
    ff = "fastfetch";
    la = "lsd -a -1 --color=auto";
    ll = "lsd -l --color=auto";
    lla = "lsd -l -a -1 --color=auto";
    ls = "lsd --color=auto";
    n = "nvim";
    update = "sudo nixos-rebuild switch --flake /etc/nixos";
  };

  # NOTE: It's not recommended to change this variable.
  # Change at your own risk.
  stateVersion = "26.05";
}
