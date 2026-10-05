{ ... }:

{
  # Allow proprietary/unfree packages such as Obsidian and other desktop software.
  nixpkgs.config.allowUnfree = true;

  # Enable the modern Nix CLI and flakes.
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Remove unused store paths automatically.
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # Periodically deduplicate files in the Nix store.
  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}