{ pkgs, lib, cfg, ... }:

lib.mkIf (cfg.install.yazi or false) {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    plugins = {
      glow = pkgs.yaziPlugins.glow;
    };

    settings = lib.mkForce {
      manager = {
        ratio = [ 1 2 4 ];

        show_hidden = true;
        show_symlink = true;

        scrolloff = 5;

        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
        sort_sensitive = false;
      };

      preview = {
        tab_size = 2;
        max_width = 2048;
        max_height = 2048;
        image_preview_delay = 10;
        image_filter = "triangle";
      };

      opener = {
        edit = [ { run = "nvim \"$@\""; block = true; desc = "Открыть в Neovim"; } ];
        play = [ { run = "mpv \"$@\""; orphan = true; desc = "Запустить видео в MPV"; } ];
        open = [ { run = "xdg-open \"$@\""; desc = "Открыть по умолчанию"; } ];
      };

      open = {
        rules = [
          { url = "*.sh"; use = "edit"; }
          { url = "*.nix"; use = "edit"; }
          { url = "*.lua"; use = "edit"; }
          { url = "*.md"; use = "edit"; }
          { mime = "text/*"; use = "edit"; }
          { mime = "video/*"; use = "play"; }
          { mime = "image/*"; use = "open"; }
          { mime = "application/pdf"; use = "open"; }
        ];
      };

      plugin = {
        previewers = [
          { mime = "image/*"; run = "image"; }
          { url = "*.md"; run = "edit"; }
          { mime = "application/json"; run = "jq"; }

          { mime = "video/*"; run = "video"; }
          { mime = "application/pdf"; run = "pdf"; }
          { mime = "font/*"; run = "font"; }
          { mime = "application/archive"; run = "archive"; }
        ];
      };
    };
  };
}
