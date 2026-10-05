{ config, pkgs, ... }:

{
  home.username = "ghostik";
  home.homeDirectory = "/home/ghostik";
  programs.git.enable = true;
  home.stateVersion = "26.05";
  programs.bash = {
    enable = true;
  };
}
