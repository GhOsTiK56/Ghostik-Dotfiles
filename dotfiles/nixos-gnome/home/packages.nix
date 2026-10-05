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
    firefox
    neovim
    wget
    vscode
    ripgrep
    fd
    fzf
    jq
    tree
    btop
    gnome-extension-manager
    gnome-tweaks
  ];
}