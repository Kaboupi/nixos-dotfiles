{ inputs, lib, cfg, ... }:

{
  imports = [
    inputs.caelestia-shell.homeManagerModules.default
  ];

  config = lib.mkIf (cfg.install.caelestia or false) {
    programs.caelestia = {
      enable = true;

      systemd = {
        enable = false;
        target = "graphical-session.target";
        environment = [];
      };

      settings = {

        appearance = {
          transparency = {
            enabled = true;
            base = "0.85";
            layers = "0.4";
          };
        };

        general = {
          apps = {
            terminal = "kitty";
            audio = "pavucontrol";
            playback = "mpv";
            explorer = "yazi";
          };
        };

        background = {
          enabled = true;
          wallpaperEnabled = true;

          desktopClock = {
            enabled = false;
            scale = "1.0";
            position = "bottom-right";
            invertColors = false;

            background = {
              enabled = true;
              opacity = "0.7";
              blur = true;
            };

            shadow = {
              enabled = true;
              opacity = "0.7";
              blur = "0.4";
            };
          };
        };

        bar = {
          showOnHover = false;

          scrollActions = {
            workspaces = false;
            volume = true;
            brightness = true;
          };

          popouts = {
            activeWindow = true;
            statusIcons = true;
            tray = true;
          };

          workspaces = {
            shown = 5;
            activeIndicator = true;
            occupiedBg = true;
            showWindows = false;
            showWindowsOnSpecialWorkspaces = true;
            maxWindowIcons = 3;
            activeTrail = true;
            perMonitorWorkspaces = true;
          };

          activeWindow = {
            compact = true;
            inverted = true;
            showOnHover = true;
          };

          tray = {
            background = false;
            recolour = false;
            compact = true;
            hiddenIcons = [
              "blueman-applet-wrapped"
            ];
          };

          status = {
            showAudio = true;
            showMicrophone = false;
            showKbLayout = true;
            showNetwork = true;
            showWifi = true;
            showBluetooth = true;
            showBattery = false;
            showLockStatus = true;
          };

          clock = {
            background = false;
            showDate = false;
            showIcon = false;
          };
        };

        border = {
          thickness = 10;
          rounding = 10;
          smoothing = 20;
        };

        dashboard = {
          enabled = true;
          showOnHover = false;

          showDashboard = true;
          showMedia = true;
          showPerformance = true;
          showWeather = true;
          mediaUpdateInterval = 500;
          resourceUpdateInterval = 1000;
          dragThreshold = 50;

          performance = {
            showBattery = false;
            showGpu = true;
            showCpu = true;
            showMemory = true;
            showStorage = true;
          };

        };

        launcher = {
          enabled = true;
          showOnHover = false;
          maxShown = 7;
          vimKeybinds = true;
          hiddenApps = [
            "blueman-adapters"
            "blueman-manager"
            "foot"
            "foot-server"
            "footclient"
            "gvim"
            "mpv"
            "nixos-manual"
            "org.gnome.Loupe"
            "org.pulseaudio.pavucontrol"
            "rofi"
            "rofi-theme-selector"
            "xterm"
          ];
        };

        services = {
          useFahrenheit = false;
          useFahrenheitPerformance = false;
          useTwelveHourClock = false;
        };

        session = {
          enabled =  true;
          vimKeybinds = true;
        };

        utilities = {
          enabled = true;

          vpn = {
            enabled = true;
            provider = [
              {
                name = "tailscale";
                interface = "rc.remote.com";
                displayName = "Tailscale VPN";
                enabled = true;
              }
            ];
          };

          quickToggles = [
            {
              id = "wifi";
              enabled = true;
            }
            {
              id = "bluetooth";
              enabled = true;
            }
            {
              id = "mic";
              enabled = true;
            }
            {
              id = "settings";
              enabled = true;
            }
            {
              id = "gameMode";
              enabled = false;
            }
            {
              id = "dnd";
              enabled = true;
            }
            {
              id = "vpn";
              enabled = true;
            }
          ];

        };

        paths.wallpaperDir = "~/Pictures/Wallpapers";
      };

      cli = {
        enable = true;
        settings = {
          theme.enableGtk = false;
        };
      };
    };
  };
}
