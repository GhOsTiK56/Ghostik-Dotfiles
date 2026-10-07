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
    steal-my-focus-window
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

    "org/gnome/Console" = {
      custom-font = "JetBrainsMono Nerd Font Mono 12";
      use-system-font = false;
    };

    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri = "file://${config.home.homeDirectory}/.config/background";
      picture-uri-dark = "file://${config.home.homeDirectory}/.config/background";
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
    # Window management
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

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Kitty";
      command = "kitty";
      binding = "<Super>Return";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "File Explorer";
      command = "nautilus";
      binding = "<Super>e";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Browser";
      command = "firefox";
      binding = "<Super>b";
    };

    # -------------------------------------------------------------------------
    # Input devices & power
    # -------------------------------------------------------------------------

    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.136752;
    };

    "org/gnome/desktop/peripherals/touchpad" = {
      two-finger-scrolling-enabled = true;
    };

    "org/gnome/desktop/session" = {
      idle-delay = gvariant.mkUint32 0;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-type = "nothing";
    };

    # -------------------------------------------------------------------------
    # Application folders
    # -------------------------------------------------------------------------

    "org/gnome/desktop/app-folders" = {
      folder-children = [
        "System"
        "Utilities"
      ];
    };

    "org/gnome/desktop/app-folders/folders/System" = {
      name = "X-GNOME-Shell-System.directory";
      translate = true;

      apps = [
        "org.gnome.baobab.desktop"
        "org.gnome.DiskUtility.desktop"
        "org.gnome.Logs.desktop"
        "org.gnome.SystemMonitor.desktop"
        "btop.desktop"
      ];
    };

    "org/gnome/desktop/app-folders/folders/Utilities" = {
      name = "Garbage";
      translate = false;

      apps = [
        "org.gnome.Decibels.desktop"
        "org.gnome.Connections.desktop"
        "org.gnome.font-viewer.desktop"
        "org.gnome.Contacts.desktop"
        "org.gnome.Characters.desktop"
        "org.gnome.Snapshot.desktop"
        "org.gnome.Showtime.desktop"
        "org.gnome.SimpleScan.desktop"
        "org.gnome.Tour.desktop"
        "org.gnome.Yelp.desktop"
        "nixos-manual.desktop"
        "vim.desktop"
        "org.gnome.Epiphany.desktop"
        "org.gnome.Music.desktop"
        "org.gnome.Maps.desktop"
      ];
    };

    # -------------------------------------------------------------------------
    # GNOME Shell
    # -------------------------------------------------------------------------

    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = gnomeExtensionIds;

      favorite-apps = [
        "firefox.desktop"
        "md.obsidian.Obsidian.desktop"
        "org.telegram.desktop.desktop"
        "kitty.desktop"
        "code.desktop"
        "dev.zed.Zed.desktop"
        "android-studio.desktop"
        "org.gnome.Nautilus.desktop"
        "steam.desktop"
        "vesktop.desktop"
        "org.gnome.Calculator.desktop"
        "LocalSend.desktop"
        "org.qbittorrent.qBittorrent.desktop"
        "org.gnome.Settings.desktop"
      ];

      last-selected-power-profile = "performance";
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
    # AppIndicator
    # -------------------------------------------------------------------------

    "org/gnome/shell/extensions/appindicator" = {
      icon-opacity = 240;
    };
  };
}