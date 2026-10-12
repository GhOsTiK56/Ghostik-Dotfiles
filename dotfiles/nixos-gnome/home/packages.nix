{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # -------------------------------------------------------------------------
    # Development
    # -------------------------------------------------------------------------

    # IDEs & Editors
    vscode                     # Code editor with a large extension ecosystem.
    zed-editor                 # Fast code editor with built-in collaboration features.
    android-studio             # IDE for Android application development.
    neovim                     # Extensible terminal-based text editor.

    # Compilers, Build Tools & Runtimes
    gcc                        # C and C++ compiler toolchain.
    gnumake                    # Automates builds using Makefiles.
    tree-sitter                # Incremental parsing library for syntax highlighting and code analysis.
    nodejs                     # JavaScript runtime.
    python3                    # Python interpreter and standard development tools.

    # Git & Code Navigation
    lazygit                    # Terminal UI for browsing Git history and managing repositories.
    ast-grep                   # Structural code search and rewriting using syntax trees.

    # -------------------------------------------------------------------------
    # Internet & Communication
    # -------------------------------------------------------------------------

    firefox                    # Web browser.
    telegram-desktop           # Telegram messaging client.
    vesktop                    # Discord client with support for Vencord.
    qbittorrent                # BitTorrent client.
    localsend                  # Transfers files between nearby devices over a local network.

    # -------------------------------------------------------------------------
    # Media & Content
    # -------------------------------------------------------------------------

    # Players & Reading
    celluloid                  # GTK video player based on MPV.
    recordbox                  # Music player and music library manager.
    obsidian                   # Markdown-based knowledge base and note-taking app.
    foliate                    # E-book reader.

    # Audio & Music Library
    easyeffects                # Audio processing and effects for PipeWire.
    flacon                     # Extracts audio tracks from files such as CUE-based albums.
    nicotine-plus              # Soulseek client for peer-to-peer music sharing.
    picard                     # MusicBrainz tool for identifying and tagging music files.

    # Recording & Media Processing
    obs-studio                 # Screen recording and live streaming.
    ffmpegthumbnailer          # Generates video thumbnails for file managers.

    # -------------------------------------------------------------------------
    # Gaming
    # -------------------------------------------------------------------------

    lutris                     # Manages and launches games from multiple sources.
    mangohud                   # In-game overlay for FPS, frame times and hardware metrics.

    # -------------------------------------------------------------------------
    # GNOME & Desktop Customization
    # -------------------------------------------------------------------------

    gnome-extension-manager    # Installs and manages GNOME Shell extensions.
    gnome-tweaks               # Advanced GNOME desktop and appearance settings.
    gdm-settings               # GUI for configuring the GNOME Display Manager.

    # -------------------------------------------------------------------------
    # Terminal & Shell
    # -------------------------------------------------------------------------

    ghostty                    # GPU-accelerated terminal emulator.
    tmux                       # Keeps terminal sessions running and organizes them into panes.
    yazi                       # Keyboard-driven terminal file manager.
    btop                       # Interactive monitor for CPU, memory, disks and processes.
    fastfetch                  # Displays system information in the terminal.
    bat                        # cat alternative with syntax highlighting and Git integration.
    lsd                        # ls alternative with colors, icons and directory listings.

    # -------------------------------------------------------------------------
    # CLI Utilities
    # -------------------------------------------------------------------------

    curl                       # Transfers data using URL-based protocols.
    wget                       # Downloads files over HTTP, HTTPS and FTP.
    fd                         # Fast, user-friendly alternative to find.
    fzf                        # Fuzzy finder for files, commands and other lists.
    jq                         # Parses, filters and transforms JSON data.
    ripgrep                    # Fast recursive text search, similar to grep.
    tree                       # Displays directories as a tree.
    unzip                      # Extracts ZIP archives.

    # -------------------------------------------------------------------------
    # Formatting & Dotfiles
    # -------------------------------------------------------------------------

    stow                       # Manages symlinks, commonly used for dotfiles.
    stylua                     # Code formatter for Lua.
    shfmt                      # Formatter for shell scripts.

    # -------------------------------------------------------------------------
    # Hardware & System Utilities
    # -------------------------------------------------------------------------

    pciutils                   # Utilities such as lspci for inspecting PCI devices.
    usbutils                   # Utilities such as lsusb for inspecting USB devices.
    openrgb                    # Controls supported RGB lighting devices.
    pavucontrol                # GUI for managing audio devices, inputs and outputs.

    # -------------------------------------------------------------------------
    # Screenshots
    # -------------------------------------------------------------------------

    flameshot                  # Screenshot capture and annotation tool.
  ];
}