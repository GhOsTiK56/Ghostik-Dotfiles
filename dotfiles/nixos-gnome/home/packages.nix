{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (obsidian.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        sed -i 's/StartupWMClass=obsidian/StartupWMClass=md.obsidian.Obsidian/' \
          $out/share/applications/obsidian.desktop
        mv $out/share/applications/obsidian.desktop \
          $out/share/applications/md.obsidian.Obsidian.desktop
      '';
    }))
    android-studio
    zed-editor
    vscode
    kitty
    firefox
    qbittorrent
    openrgb
    telegram-desktop
    vesktop
    easyeffects
    celluloid
    localsend
    fastfetch
    neovim
    btop
    zoxide
    lutris
    gnome-extension-manager
    gnome-tweaks
    wget
    ripgrep
    fd
    fzf
    jq
    tree
  ];
}