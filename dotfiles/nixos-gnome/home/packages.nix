{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # -------------------------------------------------------------------------
    # Development & Code Editors
    # -------------------------------------------------------------------------

    vscode                     # Code editor with rich extension ecosystem.
    zed-editor                 # High-performance, multiplayer code editor.
    android-studio             # Official IDE for Android application development.
    neovim                     # Hyperextensible Vim-based text editor.
    lazygit                    # Simple terminal UI for git commands.
    gcc                        # GNU Compiler Collection for C, C++, and other languages.
    gnumake                    # Utility for controlling compilation and build automation.
    tree-sitter                # Incremental parsing library for syntax analysis.
    nodejs                     # JavaScript runtime built on Chrome's V8 engine.
    python3                    # High-level, interpreted programming language.

    # -------------------------------------------------------------------------
    # Internet & Communication
    # -------------------------------------------------------------------------

    firefox                    # Privacy-focused web browser.
    telegram-desktop           # Official desktop app for Telegram messaging.
    vesktop                    # Custom Discord desktop app with Vencord support.
    qbittorrent                # Feature-rich BitTorrent client.
    localsend                  # Open-source cross-platform local file sharing.

    # -------------------------------------------------------------------------
    # Media & Audio Production
    # -------------------------------------------------------------------------

    obsidian                   # Knowledge base and Markdown note-taking app.
    obs-studio                 # Software for video recording and live streaming.
    celluloid                  # Simple GTK frontend for MPV media player.
    easyeffects                # Audio effects for PipeWire applications.
    recordbox                  # Feature-rich desktop music player for local files.
    flacon                     # Extracts individual tracks from CUE-based audio files.
    nicotine-plus              # Graphical client for Soulseek peer-to-peer network.
    picard                     # Official MusicBrainz music tagger and organizer.

    # -------------------------------------------------------------------------
    # Gaming & System Utilities
    # -------------------------------------------------------------------------

    gnome-extension-manager    # Utility to browse and manage GNOME Shell extensions.
    gnome-tweaks               # Advanced settings customization tool for GNOME desktop.
    lutris                     # Open-source gaming platform and game manager.
    mangohud                   # Vulkan and OpenGL overlay for monitoring FPS.
    openrgb                    # Open-source RGB lighting control utility.
    pavucontrol                # PulseAudio volume control graphical interface.

    # -------------------------------------------------------------------------
    # Terminal Utilities & CLI Tools
    # -------------------------------------------------------------------------

    ghostty                    # Fast, feature-rich terminal emulator.
    tmux                       # Terminal multiplexer for managing multiple shell sessions.
    yazi                       # Blazing fast terminal file manager written in Rust.
    btop                       # Resource monitor showing CPU, memory, and disks.
    fastfetch                  # Neofetch-like system information display tool.
    bat                        # Cat clone with syntax highlighting and Git integration.
    stow                       # Symlink manager for dotfiles and software packages.
    curl                       # Command-line tool for transferring data with URLs.
    fd                         # Simple, fast, and user-friendly alternative to find.
    fzf                        # General-purpose command-line fuzzy finder.
    jq                         # Lightweight command-line JSON processor.
    lsd                        # Modern replacement for the ls command with icons.
    ripgrep                    # Extremely fast line-oriented search tool.
    tree                       # Recursive directory listing program producing depth-indented lists.
    unzip                      # Utility for extracting compressed zip archives.
    wget                       # Command-line tool for retrieving files via HTTP/FTP.
    stylua                     # Opinionated Lua code formatter.
    shfmt                      # Formater for shell script files.
    ast-grep                   # Fast structural code search and replacement tool.

    # -------------------------------------------------------------------------
    # Hardware Troubleshooting
    # -------------------------------------------------------------------------

    pciutils                   # Utilities for inspecting and configuring PCI devices.
    usbutils                   # Tools for listing and inspecting USB devices.
  ];
}