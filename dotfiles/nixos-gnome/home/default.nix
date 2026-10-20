{ ... }:

{
  # Keep this at the version the Home Manager configuration originally used.
  home.stateVersion = "26.05";

  imports = [
    ./services/tg-ws-proxy.nix
    ./services/easyeffects.nix

    ./packages.nix
    ./programs.nix
    ./desktop.nix
  ];
}