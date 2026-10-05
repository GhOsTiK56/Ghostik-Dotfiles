{ pkgs, ... }:

{
  users.users.ghostik = {
    isNormalUser = true;
    description = "Ghostik";

    # Default login shell.
    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "networkmanager"
      "i2c"
    ];
  };
}