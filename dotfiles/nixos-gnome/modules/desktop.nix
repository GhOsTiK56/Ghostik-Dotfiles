{ ... }:

{
  # GNOME desktop with GDM.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # GNOME-integrated credential storage.
  services.gnome.gnome-keyring.enable = true;

  # XDG desktop portals for Wayland applications.
  xdg.portal.enable = true;
}