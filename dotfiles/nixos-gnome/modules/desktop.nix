{ ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  hardware.graphics.enable = true;

  services.gnome.gnome-keyring.enable = true;

  xdg.portal.enable = true;
}