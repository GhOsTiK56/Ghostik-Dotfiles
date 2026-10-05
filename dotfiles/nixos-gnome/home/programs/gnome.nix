{ config, lib, pkgs, ... }:

with lib.hm.gvariant;

{
  programs.gnome-shell = {
    enable = true;

    extensions = with pkgs.gnomeExtensions; [
      { package = appindicator; }
      { package = dash-to-dock; }
      { package = blur-my-shell; }
    ];
  };

  dconf.settings = {
    # Interface and appearance
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/desktop/background" = {
      picture-options = "zoom";
      picture-uri =
        "file://${config.home.homeDirectory}/.config/background";
      picture-uri-dark =
        "file://${config.home.homeDirectory}/.config/background";
    };

    "org/gnome/desktop/calendar" = {
      week-start-day = "monday";
    };

    # Windows, keyboard shortcuts and workspaces
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

    "org/gnome/mutter" = {
      dynamic-workspaces = false;
    };

    # Mouse and power
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

    # GNOME Shell
    "org/gnome/shell" = {
      enabled-extensions = [
        pkgs.gnomeExtensions.appindicator.extensionUuid
        pkgs.gnomeExtensions.dash-to-dock.extensionUuid
        pkgs.gnomeExtensions.blur-my-shell.extensionUuid
      ];

      last-selected-power-profile = "performance";
    };

    # Dash to Dock
    "org/gnome/shell/extensions/dash-to-dock" = {
      background-opacity = 0.8;
      click-action = "minimize-or-previews";
      dash-max-icon-size = 48;
      dock-position = "BOTTOM";
      height-fraction = 0.9;

      # Change this if the monitor connector is different.
      preferred-monitor-by-connector = "DP-1";

      show-mounts = false;
      show-trash = false;
    };

    # Blur My Shell
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