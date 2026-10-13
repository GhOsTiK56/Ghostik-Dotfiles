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
    vertical-workspaces
    tiling-shell
  ];

  gnomeExtensionIds =
    map (extension: extension.extensionUuid) gnomeExtensions;
in
{
  # ---------------------------------------------------------------------------
  # Cursor
  # ---------------------------------------------------------------------------

  home.pointerCursor = {
    enable = true;
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
    # Interface
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      cursor-theme = "Bibata-Modern-Ice";
      monospace-font-name = "Adwaita Mono 11";
      enable-animations = true;
      enable-hot-corners = true;
    };

    "org/gnome/GWeather4" = {
      temperature-unit = "centigrade";
    };

    # Background
    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri = "file://${config.home.homeDirectory}/.config/background";
      picture-uri-dark = "file://${config.home.homeDirectory}/.config/background";
    };

    # Input
    "org/gnome/desktop/input-sources" = {
      sources = keyboardSources;
      mru-sources = keyboardSources;
      xkb-options = [ "grp:alt_shift_toggle" ];
    };

    # Date & calendar
    "org/gnome/desktop/calendar" = {
      week-start-day = "monday";
    };

    "org/gnome/desktop/datetime" = {
      automatic-timezone = true;
    };

    # Window management
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
      num-workspaces = 3;
      resize-with-right-button = true;
    };

    "org/gnome/mutter" = {
      center-new-windows = true;
      dynamic-workspaces = false;
      edge-tiling = false;
    };

    "org/gnome/mutter/keybindings" = {
      toggle-tiled-left = [];
      toggle-tiled-right = [];
    };

    "org/gnome/desktop/wm/keybindings" = {
      close = [ "<Super>q" ];
      maximize = [];
      unmaximize = [];
      minimize = [ "<Super>s" ];

      move-to-workspace-down = [ "<Control><Shift><Alt>Down" ];
      move-to-workspace-up = [ "<Control><Shift><Alt>Up" ];
      move-to-workspace-left = [
        "<Super><Shift>KP_Prior"
        "<Super><Shift><Alt>Left"
        "<Control><Shift><Alt>Left"
        "<Super><Shift>Page_Up"
      ];
      move-to-workspace-right = [
        "<Super><Shift>KP_Next"
        "<Super><Shift><Alt>Right"
        "<Control><Shift><Alt>Right"
        "<Super><Shift>Page_Down"
      ];

      switch-to-workspace-down = [ "<Control><Alt>Down" ];
      switch-to-workspace-up = [ "<Control><Alt>Up" ];
      switch-to-workspace-left = [ "<Control><Super>h" "<Super>Page_Up" ];
      switch-to-workspace-right = [ "<Control><Super>l" "<Super>Page_Down" ];
    };

    "org/gnome/desktop/search-providers" = {
      disabled = [ "org.gnome.Epiphany.desktop" ];
      enabled = [ "org.gnome.Weather.desktop" ];
      sort-order = [
        "org.gnome.Settings.desktop"
        "org.gnome.Contacts.desktop"
        "org.gnome.Nautilus.desktop"
      ];
    };

    # Custom keyboard shortcuts
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
      ];
      screensaver = [ "<Alt><Super>l" ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      name = "Terminal";
      command = "ghostty";
      binding = "<Super>Return";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      name = "File Explorer";
      command = "nautilus";
      binding = "<Super>e";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
      name = "Screenshot";
      command = "flameshot gui";
      binding = "Print";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3" = {
      name = "Terminal";
      command = "ghostty";
      binding = "<Super>Return";
    };

    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "<Control>Print" ];
      toggle-quick-settings = [ "<Super>i" ];
    };

    # Input devices, power & break reminders
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.136752;
    };

    "org/gnome/desktop/session" = {
      idle-delay = gvariant.mkUint32 0;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      power-button-action = "interactive";
      sleep-inactive-ac-timeout = 3600;
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

    "org/gnome/desktop/sound" = {
      event-sounds = true;
      theme-name = "__custom";
    };

    # GNOME Shell
    "org/gnome/shell" = {
      disable-user-extensions = false;
      disabled-extensions = [];
      enabled-extensions = gnomeExtensionIds;
      favorite-apps = [
        "firefox.desktop"
        "md.obsidian.Obsidian.desktop"
        "org.telegram.desktop.desktop"
        "org.gnome.Nautilus.desktop"
        "org.gnome.TextEditor.desktop"
        "com.mitchellh.ghostty.desktop"
        "code.desktop"
        "android-studio.desktop"
        "steam.desktop"
        "vesktop.desktop"
        "com.github.johnfactotum.Foliate.desktop"
        "ca.edestcroix.Recordbox.desktop"
      ];
      last-selected-power-profile = "performance";
      welcome-dialog-last-shown-version = "50.5";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = false;
    };

    # Dash to Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      apply-custom-theme = false;
      background-opacity = 0.8;
      click-action = "minimize-or-previews";
      custom-background-color = false;
      custom-theme-shrink = false;
      dash-max-icon-size = 48;
      dock-position = "BOTTOM";
      height-fraction = 0.9;
      hide-tooltip = false;
      hot-keys = false;
      icon-size-fixed = false;
      preferred-monitor = -2;
      preferred-monitor-by-connector = "DP-1";
      show-apps-at-top = false;
      show-mounts = false;
      show-trash = false;
      transparency-mode = "DEFAULT";
    };

    # Just Perfection
    "org/gnome/shell/extensions/just-perfection" = {
      animation = 6;
      calendar = true;
      events-button = false;
      support-notifier-showed-version = 36;
      weather = false;
      window-demands-attention-focus = true;
      world-clock = false;
    };

    # Blur My Shell
    "org/gnome/shell/extensions/blur-my-shell" = {
      rounded-blur-found = false;
      settings-version = 2;
    };

    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 0.6;
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      pipeline = "pipeline_default_rounded";
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      corner-radius = 0;
      pipeline = "pipeline_default";
      sigma = 30;
    };

    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      pipeline = "pipeline_default";
    };

    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };

    # AppIndicator & Compiz
    "org/gnome/shell/extensions/appindicator" = {
      icon-brightness = 0.0;
      icon-contrast = 0.0;
      icon-opacity = 240;
      icon-saturation = 0.0;
      icon-size = 20;
    };

    "org/gnome/shell/extensions/com/github/hermes83/compiz-windows-effect" = {
      friction = 1.5;
      last-version = 31;
      mass = 80.0;
      maximize-effect = false;
      preset = "S";
      resize-effect = false;
      speedup-factor-divider = 6.0;
      spring-k = 1.0;
      x-tiles = 6.0;
      y-tiles = 6.0;
    };

    # Tiling Shell
    "org/gnome/shell/extensions/tilingshell" = {
      edge-tiling-mode = "default";
      enable-autotiling = false;
      enable-blur-selected-tilepreview = false;
      enable-blur-snap-assistant = false;
      enable-tiling-system = true;
      enable-tiling-system-windows-suggestions = false;
      enable-window-border = false;
      inner-gaps = gvariant.mkUint32 6;
      last-version-name-installed = "17.3";
      layouts-json = "[{\"id\":\"Layout 2\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[1]},{\"x\":0.22,\"y\":0,\"width\":0.56,\"height\":1,\"groups\":[1,2]},{\"x\":0.78,\"y\":0,\"width\":0.22,\"height\":1,\"groups\":[2]}]},{\"id\":\"496490\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.0734375,\"height\":1,\"groups\":[1]},{\"x\":0.0734375,\"y\":0,\"width\":0.8531249999999999,\"height\":0.8625954198473282,\"groups\":[2,3,1]},{\"x\":0.9265625,\"y\":0,\"width\":0.07343749999999905,\"height\":1,\"groups\":[2]},{\"x\":0.0734375,\"y\":0.8625954198473282,\"width\":0.8531249999999999,\"height\":0.13740458015267176,\"groups\":[3,2,1]}]},{\"id\":\"Layout 3\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]},{\"x\":0.33,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]}]},{\"id\":\"Layout 4\",\"tiles\":[{\"x\":0,\"y\":0,\"width\":0.67,\"height\":1,\"groups\":[1]},{\"x\":0.67,\"y\":0,\"width\":0.33,\"height\":1,\"groups\":[1]}]}]";
      outer-gaps = gvariant.mkUint32 6;
      overridden-settings = "{\"org.gnome.mutter.keybindings\":{\"toggle-tiled-right\":\"['<Super>Right']\",\"toggle-tiled-left\":\"['<Super>Left']\"},\"org.gnome.desktop.wm.keybindings\":{\"maximize\":\"['<Super>Up']\",\"unmaximize\":\"['<Super>Down', '<Alt>F5']\"},\"org.gnome.mutter\":{\"edge-tiling\":\"true\"}}";
      quarter-tiling-threshold = gvariant.mkUint32 30;
      raise-together = false;
      selected-layouts = [
        [ "Layout 2" ]
        [ "Layout 2" ]
        [ "Layout 2" ]
      ];
      show-indicator = false;
      snap-assistant-threshold = 10;
      window-use-custom-border-color = false;
    };

    # Vertical Workspaces Extension
    "org/gnome/shell/extensions/vertical-workspaces" = {
      aaa-loading-profile = false;
      activate-settings-window = 2;
      always-activate-selected-window = false;
      animation-speed-factor = 131;
      app-display-module = true;
      app-favorites-module = true;
      app-folder-close-button = true;
      app-folder-order = 0;
      app-folder-remove-button = 1;
      app-grid-active-preview = false;
      app-grid-animation = 4;
      app-grid-bg-blur-sigma = 300;
      app-grid-bg-brightness = 50;
      app-grid-columns = 0;
      app-grid-content = 2;
      app-grid-folder-center = true;
      app-grid-folder-columns = 0;
      app-grid-folder-icon-grid = 3;
      app-grid-folder-icon-size = -1;
      app-grid-folder-rows = 0;
      app-grid-folder-spacing = 12;
      app-grid-icon-size = -1;
      app-grid-incomplete-pages = false;
      app-grid-names = 1;
      app-grid-order = 0;
      app-grid-orientation = 0;
      app-grid-page-height-scale = 90;
      app-grid-page-width-scale = 85;
      app-grid-performance = false;
      app-grid-remember-page = false;
      app-grid-rows = 0;
      app-grid-show-package-type = 1;
      app-grid-show-page-arrows = true;
      app-grid-show-page-indicators = true;
      app-grid-spacing = 30;
      app-menu-close-wins-ws = true;
      app-menu-force-quit = true;
      app-menu-move-app = true;
      app-menu-window-tmb = true;
      center-app-grid = false;
      center-dash-to-ws = false;
      center-search = true;
      click-empty-close = false;
      close-ws-button-mode = 2;
      dash-bg-color = 1;
      dash-bg-gs3-style = false;
      dash-bg-opacity = 20;
      dash-bg-radius = 0;
      dash-icon-scroll = 2;
      dash-isolate-workspaces = false;
      dash-max-icon-size = 0;
      dash-module = true;
      dash-position = 2;
      dash-position-adjust = 0;
      dash-show-windows-before-activation = 0;
      enable-page-shortcuts = true;
      favorites-notify = 1;
      highlighting-style = 1;
      hot-corner-action = 2;
      hot-corner-fullscreen = true;
      hot-corner-position = 0;
      hot-corner-ripples = true;
      layout-module = true;
      message-tray-module = true;
      new-window-focus-fix = false;
      new-window-monitor-fix = false;
      notification-position = 1;
      osd-position = 6;
      osd-window-module = true;
      overlay-key-module = true;
      overlay-key-primary = 1;
      overlay-key-secondary = 1;
      overview-bg-blur-sigma = 300;
      overview-bg-brightness = 50;
      overview-esc-behavior = 0;
      overview-mode = 0;
      overview-select-window = 0;
      overview-sort-windows = 0;
      panel-module = true;
      panel-overview-style = 1;
      panel-position = 0;
      panel-visibility = 0;
      running-dot-style = 0;
      search-app-grid-mode = 1;
      search-bg-brightness = 40;
      search-controller-module = true;
      search-fuzzy = false;
      search-icon-size = 0;
      search-include-settings = true;
      search-max-results-rows = 5;
      search-module = true;
      search-results-bg-style = 0;
      search-view-animation = 0;
      search-width-scale = 100;
      search-windows-icon-scroll = 1;
      sec-wst-position-adjust = 0;
      secondary-ws-preview-scale = 95;
      secondary-ws-preview-shift = false;
      secondary-ws-thumbnail-scale = 8;
      secondary-ws-thumbnails-position = 2;
      show-app-icon-position = 1;
      show-overview-background = 1;
      show-search-entry = false;
      show-ws-preview-bg = true;
      show-ws-switcher-bg = true;
      show-wst-labels = 0;
      show-wst-labels-on-hover = true;
      smooth-overview-animation = true;
      startup-state = 1;
      swipe-tracker-module = true;
      win-attention-handler-module = true;
      win-preview-close-button = 1;
      win-preview-height-compensation = 80;
      win-preview-icon-size = 1;
      win-preview-mid-mouse-btn-action = 0;
      win-preview-sec-mouse-btn-action = 3;
      win-title-position = 0;
      window-attention-mode = 0;
      window-icon-click-action = 1;
      window-manager-module = true;
      window-preview-module = true;
      workspace-animation = 1;
      workspace-animation-module = true;
      workspace-module = true;
      workspace-switcher-animation = 0;
      workspace-switcher-popup-module = true;
      ws-max-spacing = 30;
      ws-preview-bg-radius = 30;
      ws-preview-scale = 95;
      ws-sw-popup-h-position = 50;
      ws-sw-popup-mode = 1;
      ws-sw-popup-v-position = 95;
      ws-switcher-ignore-last = false;
      ws-switcher-mode = 0;
      ws-switcher-wraparound = false;
      ws-thumbnail-scale = 13;
      ws-thumbnail-scale-appgrid = 13;
      ws-thumbnail-scale-search = 13;
      ws-thumbnails-full = false;
      ws-thumbnails-position = 5;
      wst-position-adjust = 0;
    };

    # Applications (Celluloid, Nautilus, GTK)
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

    "org/gnome/nautilus/preferences" = {
      migrated-gtk-settings = true;
      show-create-link = true;
      show-delete-permanently = true;
      show-image-thumbnails = "always";
    };

    "org/gtk/gtk4/settings/file-chooser" = {
      show-hidden = true;
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