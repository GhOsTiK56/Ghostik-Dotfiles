{ config, lib, pkgs, ... }:

let
  inherit (lib.hm) gvariant;

  keyboardSources = [
    (gvariant.mkTuple [ "xkb" "us" ])
    (gvariant.mkTuple [ "xkb" "ru" ])
  ];

  gnomeExtensions = with pkgs.gnomeExtensions; [
    appindicator
    dash-to-dock
    blur-my-shell
    just-perfection
    clipboard-indicator
    weather-oclock
    launch-new-instance
    compiz-windows-effect
    compiz-alike-magic-lamp-effect
    power-off-options
  ];

  gnomeExtensionIds =
    map (extension: extension.extensionUuid) gnomeExtensions;
in
{
  # ---------------------------------------------------------------------------
  # Cursor
  # ---------------------------------------------------------------------------

  home.pointerCursor = {
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Ice";
    size = 24;

    gtk.enable = true;
    x11.enable = true;
  };

  # ---------------------------------------------------------------------------
  # GNOME Shell
  # ---------------------------------------------------------------------------

  programs.gnome-shell = {
    enable = true;

    extensions = map (package: { inherit package; }) gnomeExtensions;
  };

  # ---------------------------------------------------------------------------
  # GNOME / dconf
  # ---------------------------------------------------------------------------

  dconf.settings = {
    # -------------------------------------------------------------------------
    # Interface
    # -------------------------------------------------------------------------

    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Bibata-Modern-Ice";
      monospace-font-name = "Adwaita Mono 11";
      enable-animations = true;
    };

    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };

    # -------------------------------------------------------------------------
    # Input
    # -------------------------------------------------------------------------

    "org/gnome/desktop/input-sources" = {
      sources = keyboardSources;
      mru-sources = keyboardSources;
      xkb-options = [ "grp:alt_shift_toggle" ];
    };

    # -------------------------------------------------------------------------
    # Date & calendar
    # -------------------------------------------------------------------------

    "org/gnome/desktop/calendar" = {
      week-start-day = "monday";
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    # -------------------------------------------------------------------------
    # Window management & Search
    # -------------------------------------------------------------------------

    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 3;
      resize-with-right-button = true;
    };

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      switch-to-workspace-left = [ "<Control><Super>h" ];
      switch-to-workspace-right = [ "<Control><Super>l" ];
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [ "org.gnome.Epiphany.desktop" ];
      sort-order = [
        "org.gnome.Settings.desktop"
        "org.gnome.Contacts.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };

    # -------------------------------------------------------------------------
    # Custom keyboard shortcuts
    # -------------------------------------------------------------------------

    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "File Explorer";
      command = "nautilus";
      binding = "<Super>e";
    };

    # -------------------------------------------------------------------------
    # Input devices, Power & Break Reminders
    # -------------------------------------------------------------------------

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.136752;
    };

    "org/gnome/desktop/session" = {
      idle-delay = gvariant.mkUint32 0;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
    };

    "org/gnome/settings-daemon/plugins/color" = {
      night-light-schedule-automatic = false;
    };

    "org/gnome/desktop/break-reminders/eyesight" = {
      play-sound = true;
    };

    "org/gnome/desktop/break-reminders/movement" = {
      duration-seconds = gvariant.mkUint32 300;
      interval-seconds = gvariant.mkUint32 1800;
      play-sound = true;
    };

    # -------------------------------------------------------------------------
    # GNOME Shell
    # -------------------------------------------------------------------------

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = gnomeExtensionIds;

      last-selected-power-profile = "performance";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = false;
    };

    # -------------------------------------------------------------------------
    # Dash to Dock
    # -------------------------------------------------------------------------

    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = false;
      background-opacity = 0.8;
      click-action = "minimize-or-previews";
      custom-theme-shrink = false;
      dash-max-icon-size = 48;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      hot-keys = false;
      icon-size-fixed = false;

      # Hardware-specific: monitor connector.
      preferred-monitor-by-connector = "DP-1";

      show-mounts = false;
      show-trash = false;
    };

    # -------------------------------------------------------------------------
    # Just Perfection
    # -------------------------------------------------------------------------

    "org/gnome/shell/extensions/just-perfection" = {
      animation = 6;
      events-button = false;
      world-clock = false;
      window-demands-attention-focus = true;
    };

    # -------------------------------------------------------------------------
    # Blur My Shell
    # -------------------------------------------------------------------------

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      blur = true;
      whitelist = [ "kitty" ];
      dynamic-opacity = false;
      opacity = 255;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      pipeline = "pipeline_default_rounded";
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      corner-radius = 0;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    # -------------------------------------------------------------------------
    # AppIndicator & Compiz
    # -------------------------------------------------------------------------

    "org/gnome/shell/extensions/appindicator" = {
      icon-brightness = 0.0;
      icon-contrast = 0.0;
      icon-opacity = 240;
      icon-saturation = 0.0;
      icon-size = 20;
    };

    "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" = {
      friction = 1.5;
      mass = 80.0;
      maximize-effect = false;
      preset = "S";
      resize-effect = false;
      speedup-factor-divider = 6.0;
      spring-k = 1.0;
      x-tiles = 6.0;
      y-tiles = 6.0;
    };

    # -------------------------------------------------------------------------
    # Applications Settings (Celluloid, System Monitor, Nautilus, GTK)
    # -------------------------------------------------------------------------

    "io/github/celluloid-player/celluloid" = {
      always-append-to-playlist = true;
      always-autohide-cursor = true;
      always-open-new-window = true;
      always-use-floating-controls = false;
      last-folder-enable = true;
      mpv-config-enable = true;
      mpv-config-file = "file://${config.home.homeDirectory}/.config/mpv/mpv.conf";
    };

    "org/gnome/nautilus/icon-view" = {
      default-zoom-level = "medium";
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = false;
    };

    "org/gtk/settings/file-chooser" = {
      date-format = "regular";
      location-mode = "path-bar";
      show-hidden = false;
      show-size-column = true;
      show-type-column = true;
      sidebar-width = 179;
      sort-column = "name";
      sort-directories-first = false;
      sort-order = "ascending";
      type-format = "category";
    };
  };
}