{
  # Keep the state version fixed.
  # Do not bump this merely because a newer NixOS release exists.
  system.stateVersion = "26.05";

  imports = [
    ./hardware-configuration.nix

    ../../modules/system.nix
    ../../modules/hardware.nix
    ../../modules/audio.nix
    ../../modules/desktop.nix
    ../../modules/fonts.nix
    ../../modules/programs.nix
  ];
}