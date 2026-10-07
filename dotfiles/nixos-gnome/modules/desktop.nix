{
  # ---------------------------------------------------------------------------
  # GNOME
  # ---------------------------------------------------------------------------

  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome.gnome-keyring.enable = true;

  # Home Manager manages GNOME through dconf.
  programs.dconf.enable = true;

  # XDG desktop portals for Wayland applications.
  xdg.portal.enable = true;
}