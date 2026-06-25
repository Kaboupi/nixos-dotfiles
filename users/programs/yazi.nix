{ pkgs, lib, cfg, ... }:

lib.mkIf (cfg.pkgsOptions.yazi.install or false) {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;

    plugins = {
      chmod = pkgs.yaziPlugins.chmod;
      lazygit = pkgs.yaziPlugins.lazygit;
      mediainfo = pkgs.yaziPlugins.mediainfo;
      piper = pkgs.yaziPlugins.piper;
      wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
    };

    settings = lib.mkForce {
      manager = {
        ratio = [ 1 2 5 ];

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
        image_filter = "lanczos3";
        image_quality = 90;
      };

      opener = {
        play = [ { run = "mpv %s"; orphan = true; desc = "Open in MPV"; } ];
        edit = [ { run = "$EDITOR %s"; block = true; desc = "Open in Neovim"; } ];
        open = [ { run = "xdg-open %s"; desc = "Open with default handler"; } ];
      };

      open = {
        rules = [
          { mime = "text/*"; use = "edit"; }
          { mime = "video/*"; use = "play"; }
          { mime = "image/*"; use = "open"; }

          { mime = "application/pdf"; use = "open"; }

          { url = "*"; use = "edit"; }
        ];
      };

      plugin = {
        previewers = [
          { url = "*.md"; run = "piper -- CLICOLOR_FORCE=1 glow -w=$w -s=dark \"$1\""; }
          { url = "*.tar"; run = "piper --format=url -- tar tf \"$1\""; }

          { mime = "{audio,video,image}/*"; run = "mediainfo"; }
          { mime = "font/*"; run = "font"; }

          { mime = "application/archive"; run = "archive"; }
          { mime = "application/json"; run = "piper -- jq --color-output . \"$1\""; }
          { mime = "application/pdf"; run = "pdf"; }

          { url = "*"; run = "piper -- bat -p --color=always \"$1\""; }
          { url = "*/"; run = "piper -- eza -TL=3 --color=always --icons=always --group-directories-first --no-quotes \"$1\""; }
        ];
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        { on = ["<C-g>"]; run = "plugin lazygit"; desc = "Lazygit"; }

        { on = ["<S-Y>"]; run = "plugin wl-clipboard"; desc = "WLC"; }
        { on = ["<S-M>"]; run = "plugin chmod"; desc = "Change file[s] mode"; }

        { on = ["<F3>"]; run = "plugin mediainfo -- toggle-metadata"; desc = "Toggle metadata"; }
        { on = ["<F4>"]; run = "plugin mediainfo -- toggle-preview"; desc = "Toggle preview"; }
      ];
    };
  };
}
