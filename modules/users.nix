{ pkgs, ... }:

{
  users.users.ghostik = {
    isNormalUser = true;
    description = "Ghostik";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "networkmanager" "i2c" ];
  };

  # Kept from the original configuration because it may work around missing
  # GTK3 schemas in some graphical applications. Remove only after testing
  # those applications without it.
  environment.extraInit = ''
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  '';
}
