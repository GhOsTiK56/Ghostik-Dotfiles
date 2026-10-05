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
    vscode
    gnome-extension-manager
    gnome-tweaks
    neovim
    btop
    wget
    ripgrep
    fd
    fzf
    jq
    tree
  ];
}