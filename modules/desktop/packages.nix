{ pkgs, cfg, ... }:

let
  basePackages = [
    "btop"
    "curl"
    "fd"
    "ffmpegthumbnailer"
    "fontforge"
    "foot"
    "fzf"
    "gcc"
    "git"
    "github-cli"
    "gnumake"
    "grim"
    "hyprlock"
    "hyprpaper"
    "kitty"
    "lazygit"
    "loupe"
    "neovim"
    "nodejs"
    "pavucontrol"
    "poppler"
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
    "yazi"
  ];
in
{
  environment.systemPackages = map (name: pkgs.${name}) (basePackages ++ cfg.extraPackages);
}
