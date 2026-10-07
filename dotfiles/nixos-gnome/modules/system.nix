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