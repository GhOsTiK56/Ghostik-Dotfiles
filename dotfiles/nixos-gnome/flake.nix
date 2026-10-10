{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    tg-ws-proxy-src = {
      url = "github:Flowseal/tg-ws-proxy";
      flake = false;
    };
  };

  outputs =
    { nixpkgs
    , home-manager
    , tg-ws-proxy-src
    , ...
    }:
    {
      nixosConfigurations.NixOS = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          ./hosts/desktop
          home-manager.nixosModules.default

          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {
                inherit tg-ws-proxy-src;
              };

              users.ghostik = ./home;
            };
          }
        ];
      };
    };
}