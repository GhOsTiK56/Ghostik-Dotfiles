{ pkgs, ... }:

{
  home.packages = with pkgs; [
    # --- Code Editors & IDEs & Terminals ---
    vscode                     # Code editor with a large extension ecosystem.
    android-studio             # IDE for Android application development.
    neovim                     # Extensible terminal-based text editor.
    ghostty                    # GPU-accelerated terminal emulator.
    
    # --- Browsers & Communication ---
    firefox                    # Web browser.
    telegram-desktop           # Telegram messaging client.
    vesktop                    # Discord client with support for Vencord.

    # --- Utilities & Productivity ---
    qbittorrent                # BitTorrent client.
    localsend                  # Transfers files between nearby devices over a local network.
    obsidian                   # Markdown-based knowledge base and note-taking app.
    foliate                    # E-book reader.
    flameshot                  # Screenshot capture and annotation tool.
    gnome-extension-manager    # Installs and manages GNOME Shell extensions.
    gnome-tweaks               # Advanced GNOME desktop and appearance settings.

    # --- Multimedia & Gaming ---
    lutris                     # Manages and launches games from multiple sources.
    mangohud                   # In-game overlay for FPS, frame times and hardware metrics.
    cine                       # GTK video player based on MPV.
    recordbox                  # Music player and music library manager.
    nicotine-plus              # Soulseek client for peer-to-peer music sharing.
    obs-studio                 # Screen recording and live streaming.
    ffmpeg                     # Solution to record, convert and stream audio and video.
    ffmpegthumbnailer          # Generates video thumbnails for file managers.
    pavucontrol                # GUI for managing audio devices, inputs and outputs.
    
    # --- Flutter & Android Development ---
    flutter                    # UI toolkit for cross-platform applications.
    jdk17                      # Java Development Kit required for Android builds.
    cmake                      # Cross-platform build system.
    ninja                      # Small build system focused on speed.
    pkg-config                 # Helper tool used when compiling applications.
    android-tools              # CLI tools for Android development (adb, fastboot, etc.).

    # --- CLI Tools & File Managers ---
    yazi                       # Keyboard-driven terminal file manager.
    btop                       # Interactive monitor for CPU, memory, disks and processes.
    tmux                       # Keeps terminal sessions running and organizes them into panes.
    fastfetch                  # Displays system information in the terminal.
    bat                        # cat alternative with syntax highlighting and Git integration.
    lsd                        # ls alternative with colors, icons and directory listings.
    lazygit                    # Terminal UI for browsing Git history and managing repositories.
    ast-grep                   # Structural code search and rewriting using syntax trees.

    # --- Compilers, Runtimes & Build Tools ---
    gcc                        # C and C++ compiler toolchain.
    gnumake                    # Automates builds using Makefiles.
    tree-sitter                # Incremental parsing library for syntax highlighting.
    nodejs                     # JavaScript runtime.
    python3                    # Python interpreter and standard development tools.

    # --- General CLI & File Utilities ---
    curl                       # Transfers data using URL-based protocols.
    wget                       # Downloads files over HTTP, HTTPS and FTP.
    fd                         # Fast, user-friendly alternative to find.
    fzf                        # Fuzzy finder for files, commands and other lists.
    jq                         # Parses, filters and transforms JSON data.
    ripgrep                    # Fast recursive text search, similar to grep.
    tree                       # Displays directories as a tree.
    unzip                      # Extracts ZIP archives.
    stow                       # Manages symlinks, commonly used for dotfiles.

    # --- Formatters & System Inspection ---
    stylua                     # Code formatter for Lua.
    shfmt                      # Formatter for shell scripts.
    pciutils                   # Utilities such as lspci for inspecting PCI devices.
    usbutils                   # Utilities such as lsusb for inspecting USB devices.
  ];
}