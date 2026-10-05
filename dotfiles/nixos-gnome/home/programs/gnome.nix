{ pkgs, lib, ... }:

with lib.hm.gvariant;

{

  home.activation.fixSteamIcons = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    for f in ~/.local/share/applications/*.desktop; do
      [ -f "$f" ] || continue
      
      # Достаем ID игры из строки Exec (используем gnugrep вместо gnrep)
      id=$(${pkgs.gnugrep}/bin/grep -Eo 'steam://rungameid/[0-9]+' "$f" | ${pkgs.gnused}/bin/sed 's#.*/##') || true
      [ -n "$id" ] || continue

      want="StartupWMClass=steam_app_$id"
      
      if ! ${pkgs.gnugrep}/bin/grep -q "StartupWMClass=" "$f"; then
        echo "$want" >> "$f"
      fi
    done
  '';

  programs.gnome-shell = {
    enable = true;
    extensions = with pkgs.gnomeExtensions; [
      { package = appindicator; }
      { package = dash-to-dock; }
      { package = blur-my-shell; }
    ];
  };

  dconf.settings = {
    # 1. Интерфейс и внешний вид
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri = "file:///home/ghostik/.config/background";
      picture-uri-dark = "file:///home/ghostik/.config/background";
    };

    "org/gnome/desktop/calendar" = {
      week-start-day = "monday";
    };

    # 2. Окна, горячие клавиши и рабочие столы
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 3;
      resize-with-right-button = true;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      switch-to-workspace-left = [ "<Control><Super>h" ];
      switch-to-workspace-right = [ "<Control><Super>l" ];
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    # 3. Периферия и питание
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.136752;
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 0;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
    };

    # 4. GNOME Shell
    "org/gnome/shell" = {
      favorite-apps = [
        "firefox.desktop"
        "md.obsidian.Obsidian.desktop"
        "code.desktop"
        "org.gnome.Console.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.Calculator.desktop"
        "org.gnome.Settings.desktop"
      ];
      last-selected-power-profile = "performance";
    };

    # 5. Расширение Dash to Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.8;
      click-action = "minimize-or-previews";
      dash-max-icon-size = 48;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      preferred-monitor-by-connector = "DP-1";
      show-mounts = false;
      show-trash = false;
    };

    # 6. Расширение Blur my Shell (только кастомные параметры прозрачности/размытия)
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      pipeline = "pipeline_default_rounded";
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };
  };
}