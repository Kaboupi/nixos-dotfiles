# NixOS Dotfiles

Minimal NixOS configuration with Hyprland.

## Quick Start

1. Clone the repo:

```bash
git clone https://github.com/Kaboupi/nixos-dotfiles.git
cd nixos-dotfiles
```

2. Edit `config.nix` with your parameters:

```nix
{
  username = "your-username";
  hostname = "your-hostname";
  timezone = "Europe/Moscow";
  locale = "en_US.UTF-8";
  stateVersion = "26.05";
}
  ```

3. Replace `hosts/hardware.nix` with your `hardware-configuration.nix`:

> To generate `hardware-configuration.nix` use the following command:
> 
> ```bash
> nixos-generate-config --root /mnt
> ```

```bash
cp /etc/nixos/hardware-configuration.nix hosts/hardware.nix
```

4. Build and switch:

```bash
sudo nixos-rebuild switch --flake .
```
