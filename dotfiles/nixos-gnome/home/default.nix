{ ... }:

{
  home.username = "ghostik";
  home.homeDirectory = "/home/ghostik";

  home.stateVersion = "26.05";

  imports = [
    ./packages.nix

    ./programs/git.nix
    ./programs/gnome.nix
    ./programs/mpv.nix
    ./programs/zoxide.nix
  ];
}
