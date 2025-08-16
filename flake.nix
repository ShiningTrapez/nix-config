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

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixos-cli,
    ...
  }: let
    lib = nixpkgs.lib.extend (
      self: super: { custom = import ./lib { inherit (nixpkgs) lib; }; }
    );

    supportedSystems = ["x86_64-linux"];
    forAllSystems = f: lib.genAttrs supportedSystems f;
    hostname = "RainbowMachine";
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = pkgs.mkShell {
          packages = with pkgs; [
            alejandra
            statix
            deadnix
          ];
        };
      }
    );

    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit lib inputs;
      };

      modules = [
        ./overlays.nix
        ./hardware/${hostname}.nix
        ./config
        ./system

        nixos-cli.nixosModules.nixos-cli

        home-manager.nixosModules.home-manager

        ./modules
      ];
    };
  };
}
