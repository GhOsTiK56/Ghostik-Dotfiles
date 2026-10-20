{ pkgs, ... }:

{
  users.users.ghostik = {
    isNormalUser = true;
    description = "Ghostik";
    shell = pkgs.fish;
    extraGroups = [
      "wheel"
      "networkmanager"
      "i2c"
      "kvm"
    ];
  };

  # Fix Gsettings for Amnezia-VPN
  environment.extraInit = ''
    export XDG_DATA_DIRS="$XDG_DATA_DIRS:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}"
  '';
}
