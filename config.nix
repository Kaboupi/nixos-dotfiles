{
  username = "kaboupi";
  hostname = "kaboupi-nixos";

  timezone = "Europe/Moscow";
  locale = "en_US.UTF-8";

  stateVersion = "26.05";

  basePackages = [
    "curl"
    "fd"
    "foot"
    "gcc"
    "git"
    "github-cli"
    "gnumake"
    "hyprpaper"
    "kitty"
    "lazygit"
    "neovim"
    "ripgrep"
    "tree"
    "unzip"
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
    n = "nvim";
    lasts = "last | grep still";
  };
}
