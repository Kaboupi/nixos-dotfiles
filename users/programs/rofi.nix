{ pkgs, config, ... }:

{
  home.packages = with pkgs; [ rofi ];

  # NOTE: Theme based on Aditya Shakya's (adi1090x) repo:
  # https://github.com/adi1090x/rofi

  xdg.configFile."rofi/theme.rasi".text = ''
    * {
        background: #0b0f19bf;
        background-alt: #16203599;

        selected: #1f2d47e6;
        active: #00dffc;
        foreground: #f1f5f9;

        border-colour:               @selected;
        handle-colour:               @selected;
        background-colour:           @background;
        foreground-colour:           @foreground;
        alternate-background:        @background-alt;
        normal-background:           @background;
        normal-foreground:           @foreground;
        urgent-foreground:           @background;
        active-background:           @active;
        active-foreground:           @background;
        selected-normal-background:  @selected;
        selected-normal-foreground:  @foreground;
        selected-urgent-background:  @active;
        selected-urgent-foreground:  @background;
        selected-active-foreground:  @background;
        alternate-normal-background: @background;
        alternate-normal-foreground: @foreground;
        alternate-urgent-foreground: @background;
        alternate-active-background: @active;
        alternate-active-foreground: @background;
    }
  '';

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi:                       "run,drun,window";
      sidebar-mode:               true;
      show-icons:                 true;

      display-run:                " Run ";
      display-drun:               " Apps ";
      display-window:             " Win ";

      markup-rows:                true;
      drun-display-format:        "{icon} {name} [<span weight='light' size='small'><i>({generic})</i></span>]";
      window-format:              "{w} · {c} · {t}";
    }

    @theme "theme"

    element-text, element-icon, mode-switcher {
      background-color: transparent;
      text-color:       inherit;
    }

    window {
        transparency:                "real";
        location:                    center;
        anchor:                      center;

        fullscreen:                  false;
        width:                       750px;
        height:                      520px;

        enabled:                     true;
        margin:                      0px;
        padding:                     0px;

        border:                      2px solid;
        border-color:                @active;
        border-radius:               16px;

        background-color:            @background;
    }

    mainbox {
        enabled:                     true;
        spacing:                     15px;
        margin:                      0px;
        padding:                     25px;
        background-color:            transparent;
        children:                    [ "inputbar", "listview", "mode-switcher" ];
    }

    inputbar {
        enabled:                     true;
        spacing:                     10px;
        margin:                      0px;
        padding:                     12px;
        border-radius:               10px;
        background-color:            @background-alt;
        text-color:                  @foreground-colour;
        children:                    [ "entry" ];
    }

    entry {
        enabled:                     true;
        background-color:            transparent;
        text-color:                  inherit;
        cursor:                      text;
        placeholder:                 "⌕ Type here to search...";
        placeholder-color:           inherit;
        vertical-align:              0.5;
        horizontal-align:            0.0;
    }

    listview {
        enabled:                     true;
        columns:                     1;
        lines:                       7;
        cycle:                       true;
        dynamic:                     true;
        scrollbar:                   false;
        layout:                      vertical;
        fixed-height:                true;
        fixed-columns:               true;

        spacing:                     6px;
        margin:                      0px;
        padding:                     5px 0px;
        background-color:            transparent;
    }

    element {
        enabled:                     true;
        spacing:                     15px;
        padding:                     8px;
        border-radius:               10px;
        background-color:            transparent;
        text-color:                  @foreground-colour;
    }

    element normal.normal { background-color: transparent; }
    element alternate.normal { background-color: transparent; }

    element selected.normal {
        background-color:            @selected;
        text-color:                  @foreground-colour;
        border:                      1px solid;
        border-color:                @active;
    }

    element-icon {
        background-color:            transparent;
        size:                        32px;
    }

    element-text {
        background-color:            transparent;
        text-color:                  inherit;
        vertical-align:              0.5;
    }

    mode-switcher {
        enabled:                     true;
        spacing:                     15px;
        background-color:            transparent;
    }

    button {
        padding:                     10px;
        border-radius:               10px;
        background-color:            @background-alt;
        text-color:                  @foreground-colour;
        cursor:                      pointer;
    }

    button selected {
        background-color:            @selected;
        text-color:                  @active;
        border:                      1px solid;
        border-color:                @active;
    }
  '';

  xdg.desktopEntries = {
    rofi = {
      name = "Rofi";
      exec = "rofi";
      noDisplay = true;
    };
    rofi-theme-selector = {
      name = "Rofi Theme Selector";
      exec = "rofi-theme-selector";
      noDisplay = true;
    };
  };
}
