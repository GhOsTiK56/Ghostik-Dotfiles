{ ... }:

{
  # System timezone.
  time.timeZone = "Europe/Moscow";

  # Default system locale.
  i18n.defaultLocale = "en_US.UTF-8";

  # Keyboard layouts and layout switching.
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };
}