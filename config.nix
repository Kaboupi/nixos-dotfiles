{
  username = "kaboupi";
  hostname = "kaboupi-nixos";

  timezone = "Europe/Moscow";
  locale = "en_US.UTF-8";

  stateVersion = "26.05";

  basePackages = [
    "curl"
    "foot"
    "git"
    "github-cli"
    "hyprpaper"
    "kitty"
    "neovim"
    "tree"
    "vim"
    "waybar"
    "wget"
    "wofi"
  ];

  extraPackages = [
  ];

  userPackages = [
  ];

  shellAliases = {
    lasts = "last | grep still";
  };
}
