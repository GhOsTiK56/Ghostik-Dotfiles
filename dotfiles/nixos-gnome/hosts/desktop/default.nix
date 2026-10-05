{
  imports = [
    ./hardware-configuration.nix

    ../../modules/programs.nix
    ../../modules/hardware.nix
    ../../modules/boot.nix
    ../../modules/desktop.nix
    ../../modules/locale.nix
    ../../modules/audio.nix
    ../../modules/networking.nix
    ../../modules/nix.nix
    ../../modules/users.nix
    ../../modules/fonts.nix
  ];
}