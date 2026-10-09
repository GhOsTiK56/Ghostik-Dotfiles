{ pkgs, ... }:

{
  # ---------------------------------------------------------------------------
  # Nix
  # ---------------------------------------------------------------------------

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };

  # ---------------------------------------------------------------------------
  # Boot
  # ---------------------------------------------------------------------------

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 
  # Resume hibernated system from the dedicated swap partition.
  boot.resumeDevice =
    "/dev/disk/by-uuid/99ca6228-85a3-47f1-af55-b3cc6c8b47b0";

  # ---------------------------------------------------------------------------
  # Networking
  # ---------------------------------------------------------------------------

  networking.hostName = "NixOS";
  networking.networkmanager.enable = true;

  # ---------------------------------------------------------------------------
  # Locale & keyboard
  # ---------------------------------------------------------------------------

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us,ru";
    variant = ",";
    options = "grp:alt_shift_toggle";
  };

  # ---------------------------------------------------------------------------
  # User
  # ---------------------------------------------------------------------------

  users.users.ghostik = {
    isNormalUser = true;
    description = "Ghostik";

    shell = pkgs.fish;

    extraGroups = [
      "wheel"
      "networkmanager"
      "i2c"
    ];
  };
}