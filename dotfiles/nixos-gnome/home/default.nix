{ ... }:

{
  home.username = "ghostik";
  home.homeDirectory = "/home/ghostik";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  imports = [
    ./packages.nix
    ./programs/git.nix
    ./programs/shell.nix
  ];
}
