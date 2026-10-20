{ ... }:

{
  system.stateVersion = "26.05";

  imports = [
    ./hardware-configuration.nix
    ../../modules/nix.nix
    ../../modules/boot.nix
    ../../modules/networking.nix
    ../../modules/users.nix
    ../../modules/hardware
    ../../modules/services/audio.nix
    ../../modules/desktop/gnome.nix
    ../../modules/storage.nix
    ../../modules/fonts.nix
    ../../modules/programs.nix
  ];
}