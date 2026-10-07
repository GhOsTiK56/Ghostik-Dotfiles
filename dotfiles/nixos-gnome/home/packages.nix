{ pkgs, ... }:

let
  obsidian = pkgs.obsidian.overrideAttrs (old: {
    # Fix GNOME application grouping for Obsidian on Wayland.
    postInstall = (old.postInstall or "") + ''
      sed -i 's/StartupWMClass=obsidian/StartupWMClass=md.obsidian.Obsidian/' \
        $out/share/applications/obsidian.desktop

      mv $out/share/applications/obsidian.desktop \
        $out/share/applications/md.obsidian.Obsidian.desktop
    '';
  });
in
{
  home.packages = with pkgs; [
    # -------------------------------------------------------------------------
    # Desktop applications
    # -------------------------------------------------------------------------

    android-studio
    zed-editor
    vscode
    firefox
    kitty

    qbittorrent
    telegram-desktop
    vesktop
    obs-studio

    openrgb
    easyeffects
    celluloid
    localsend
    lutris
    mangohud
    pavucontrol

    gnome-extension-manager
    gnome-tweaks

    # -------------------------------------------------------------------------
    # Development & CLI tools
    # -------------------------------------------------------------------------

    neovim
    fastfetch
    stow
    btop
    lazygit
    tmux

    wget
    curl

    ripgrep
    lsd
    bat
    fd
    fzf
    jq
    tree
    unzip

    # -------------------------------------------------------------------------
    # Hardware troubleshooting
    # -------------------------------------------------------------------------

    pciutils
    usbutils

    # -------------------------------------------------------------------------
    # Applications with local patches
    # -------------------------------------------------------------------------

    obsidian
  ];
}