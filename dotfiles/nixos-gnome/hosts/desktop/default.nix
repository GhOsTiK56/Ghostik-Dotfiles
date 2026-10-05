{
  # Keep the state version fixed for compatibility.
  system.stateVersion = "26.05";

  imports = [
    ./hardware-configuration.nix

    ../../modules/audio.nix
    ../../modules/boot.nix
    ../../modules/desktop.nix
    ../../modules/fonts.nix
    ../../modules/hardware.nix
    ../../modules/locale.nix
    ../../modules/networking.nix
    ../../modules/nix.nix
    ../../modules/programs.nix
    ../../modules/users.nix
  ];
}