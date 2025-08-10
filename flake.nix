{
  description = "NixOS Config Flake - Rainbow Machine";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable?shallow=1";

    home-manager = {
      url = "github:nix-community/home-manager/master?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli = {
      url = "github:nix-community/nixos-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-cli,
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
        ./options.nix
        ./system

        nixos-cli.nixosModules.nixos-cli

        home-manager.nixosModules.home-manager

        ({
          config,
          inputs,
          ...
        }: let
          user = config.user;
          homeDir = config.homeDir;
        in {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "bak";

          home-manager.extraSpecialArgs.inputs = {
            inherit inputs;
            nixosConfig = config;
          };

          home-manager.users."${user}" = {
            home.stateVersion = "23.11";

            home.username = user;
            home.homeDirectory = homeDir;

            imports = [
              ./programs
              ./config
            ];

            programs.home-manager.enable = true;
          };
        })
      ];
    };
  };
}
