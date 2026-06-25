{ pkgs, cfg, lib, ... }:

let
  # "hyprlock"
  basePackages = [
    "bat"
    "btop"
    "curl"
    "fail2ban"
    "fd"
    "fontforge"
    "fzf"
    "gcc"
    "git"
    "github-cli"
    "gnumake"
    "grim"
    "hyprpaper"
    "jq"
    "lazygit"
    "loupe"
    "lsd"
    "mpv"
    "neovim"
    "nodejs"
    "openssl"
    "pavucontrol"
    "poppler"
    "poppler-utils"
    "pulsemixer"
    "python3"
    "quickshell"
    "ripgrep"
    "rofi"
    "slurp"
    "steam-run"
    "tree"
    "tty-clock"
    "unzip"
    "vim"
    "wget"
    "wl-clipboard"
    "zoxide"
  ];
in
{
  environment.systemPackages = let
    allStringNames = lib.flatten (
      basePackages

      # NOTE: Extra from config
      ++ cfg.extraPackages

      # yazi
      ++ lib.optional (cfg.install.yazi or false) [
        "exiftool"
        "ffmpegthumbnailer"
        "glow"
        "imagemagick"
        "yazi"
      ]

      # kitty
      ++ lib.optional (cfg.install.kitty or false) [ "kitty" ]
    );
  in
    map (name: pkgs.${name}) allStringNames;
}
