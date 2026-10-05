{ ... }:

{
  networking.hostName = "NixOS";

  networking.networkmanager.enable = true;

  networking.firewall.enable = true;
}