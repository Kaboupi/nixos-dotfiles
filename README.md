# NixOS Dotfiles

Minimal NixOS configuration with Hyprland.

## Quick Start

1. Clone the repo:
   ```bash
   git clone https://github.com/your-username/nixos-dotfiles.git
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
   ```bash
   cp /etc/nixos/hardware-configuration.nix hosts/hardware.nix
   ```

4. Build and switch:
   ```bash
   sudo nixos-rebuild switch --flake .
   ```

## Structure

```
.
├── config.nix              # Your parameters (edit this)
├── flake.nix
├── hosts/
│   ├── default.nix         # Host configuration
│   └── hardware.nix        # Your hardware config (replace this)
├── home/
│   ├── home.nix            # Home Manager config
│   └── config/
│       └── hypr/           # Hyprland config files
└── modules/
    └── system/
        └── core.nix        # Core system settings
```
