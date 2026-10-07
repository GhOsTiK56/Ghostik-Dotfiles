{ ... }:

{
  # Keep this at the version the Home Manager configuration originally used.
  home.stateVersion = "26.05";

  imports = [
    ./packages.nix
    ./programs.nix
    ./desktop.nix
    ./services/tg-ws-proxy.nix
  ];
}