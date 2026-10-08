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
    # Hardware troubleshooting
    # -------------------------------------------------------------------------

    obs-studio               # Software for video recording and live streaming.
    celluloid                # Simple GTK frontend for MPV media player.
    easyeffects              # Audio effects for PipeWire applications.
    recordbox                # Feature-rich desktop music player for local files.
    flacon                   # Extracts individual tracks from CUE-based audio files.
    nicotine-plus            # Graphical client for Soulseek peer-to-peer network.
    picard                   # Official MusicBrainz music tagger and organizer.

    # -------------------------------------------------------------------------
    # Gaming & System Utilities
    # -------------------------------------------------------------------------

    gnome-extension-manager  # Utility to browse and manage GNOME Shell extensions.
    gnome-tweaks             # Advanced settings customization tool for GNOME desktop.
    lutris                   # Open-source gaming platform and game manager.
    mangohud                 # Vulkan and OpenGL overlay for monitoring FPS.
    openrgb                  # Open-source RGB lighting control utility.
    pavucontrol              # PulseAudio volume control graphical interface.

    # -------------------------------------------------------------------------
    # Terminal Utilities & CLI Tools
    # -------------------------------------------------------------------------

    ghostty                  # Fast, feature-rich terminal emulator.
    tmux                     # Terminal multiplexer for managing multiple shell sessions.
    yazi
    btop                     # Resource monitor showing CPU, memory, and disks.
    fastfetch                # Neofetch-like system information display tool.
    bat                      # Cat clone with syntax highlighting and Git integration.
    stow                     # Symlink manager for dotfiles and software packages.
    curl                     # Command-line tool for transferring data with URLs.
    fd                       # Simple, fast, and user-friendly alternative to find.
    fzf                      # General-purpose command-line fuzzy finder.
    jq                       # Lightweight command-line JSON processor.
    lsd                      # Modern replacement for the ls command with icons.
    ripgrep                  # Extremely fast line-oriented search tool.
    tree                     # Recursive directory listing program producing depth-indented lists.
    unzip                    # Utility for extracting compressed zip archives.
    wget                     # Command-line tool for retrieving files via HTTP/FTP.

    # -------------------------------------------------------------------------
    # Hardware Troubleshooting
    # -------------------------------------------------------------------------

    pciutils                 # Utilities for inspecting and configuring PCI devices.
    usbutils                 # Tools for listing and inspecting USB devices.

    # -------------------------------------------------------------------------
    # Applications with local patches
    # -------------------------------------------------------------------------

    obsidian
  ];
}