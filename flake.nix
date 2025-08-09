{
  description = "NixOS Config Flake - Rainbow Machine";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable?shallow=1";

    home-manager = {
      url = "github:nix-community/home-manager/master?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    hostname = "RainbowMachine";
    system = "x86_64-linux";
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      specialArgs.inputs = inputs;
      modules = [
        ./overlays.nix
        ./hardware/${hostname}.nix
        ./system

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
