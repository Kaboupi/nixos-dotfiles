{ pkgs, cfg, lib, ... }:

let
  basePackages = [
    "bat"
    "btop"
    "cargo"
    "chafa"
    "claude-code"
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
    "kind"
    "kubectl"
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
    "qrencode"
    "quickshell"
    "ripgrep"
    "rofi"
    "rust-analyzer"
    "rustc"
    "rustfmt"
    "slurp"
    "steam-run"
    "tmux"
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
      ++ lib.optional (cfg.pkgsOptions.yazi.install or false) [
        "ffmpegthumbnailer"
        "glow"
        "imagemagick"
        "mediainfo"
        "yazi"
      ]

      # kitty
      ++ lib.optional (cfg.pkgsOptions.kitty.install or false) [ "kitty" ]
    );
  in
    map (name: pkgs.${name}) allStringNames;
}
