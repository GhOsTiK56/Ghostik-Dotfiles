{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # Desktop applications
    android-studio # IDE for Android development
    zed-editor # Fast modern code editor
    vscode # Universal IDE/editor
    firefox # Web browser
    kitty # GPU-accelerated terminal emulator

    qbittorrent # BitTorrent GUI client
    telegram-desktop # Telegram desktop client
    vesktop # Discord desktop client based on Vencord

    openrgb # Managing RGB light
    easyeffects # PipeWire effects, EQ, compressor, filters

    celluloid # GUI frontend for mpv
    localsend # File transfer between devices on a local network

    lutris # Game launcher / game management

    gnome-extension-manager # GUI for managing GNOME extensions
    gnome-tweaks # Additional GNOME settings

    # Development and CLI tools
    neovim # Terminal editor
    fastfetch # System information in terminal
    btop # Interactive process/resource monitor

    wget # Download utility
    curl # HTTP/network transfer tool

    ripgrep # Very fast text search (rg)
    fd # Alternative for find
    fzf # Interactive fuzzy finder
    jq # Proccessing JSON from terminal
    tree # Show catalog tree

    unzip # Work with zip

    # Hardware troubleshooting utilities
    pciutils # Utilities for viewing PCI hardware (lspci)
    usbutils # Utilities for USB hardware (lsusb)

    (obsidian.overrideAttrs (old: {
      # Fix GNOME application grouping for Obsidian on Wayland.
      postInstall = (old.postInstall or "") + ''
        sed -i 's/StartupWMClass=obsidian/StartupWMClass=md.obsidian.Obsidian/' \
          $out/share/applications/obsidian.desktop

        mv $out/share/applications/obsidian.desktop \
          $out/share/applications/md.obsidian.Obsidian.desktop
      '';
    }))
  ];
}