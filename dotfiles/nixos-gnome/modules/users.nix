{ pkgs, ... }:

{
  users.users.ghostik = {
    isNormalUser = true;
    description = "Ghostik";

    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}