{ ... }:

{
  users.users.ghostik = {
    isNormalUser = true;
    description = "Ghostik";

    extraGroups = [
      "wheel"
      "networkmanager"
    ];
  };
}