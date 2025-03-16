{
  description = "NixOS Config Flake - Rainbow Machine";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable?shallow=1";
    nixpkgs-24.url = "github:NixOS/nixpkgs/nixos-24.11?shallow=1";

    home-manager = {
      url = "github:nix-community/home-manager/master?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    bandithedoge-nur.url = "github:bandithedoge/nur-packages/master?shallow=1";
  };

  outputs = {
    nixpkgs,
    home-manager,
    nur,
    ...
  } @ inputs: let
    hostname = "RainbowMachine";
  in {
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs.inputs = inputs;
      modules = [
        ./overlays.nix
        ./hardware/${hostname}.nix
        ./system

        # https://nur.nix-community.org
        nur.modules.nixos.default

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";

          home-manager.extraSpecialArgs.inputs = inputs;
          home-manager.users.sophia = {
            home.stateVersion = "23.11";

            home.username = "sophia";
            home.homeDirectory = "/home/sophia";

            imports = [
              ./programs
              ./config
            ];

            programs.home-manager.enable = true;
          };
        }
      ];
    };
  };
}
