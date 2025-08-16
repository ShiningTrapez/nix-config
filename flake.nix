{
  description = "NixOS Config Flake - Rainbow Machine";

  nixConfig = {
    substituters = [
      "https://cache.nixos.org"
      "https://watersucks.cachix.org"
    ];

    trusted-substituters = [
      "https://cache.nixos.org"
      "https://watersucks.cachix.org"
    ];

    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "watersucks.cachix.org-1:6gadPC5R8iLWQ3EUtfu3GFrVY7X6I4Fwz/ihW25Jbv8="
    ];

    extra-experimental-features = ["nix-command" "flakes"];
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
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
      self: super: {custom = import ./lib {inherit (nixpkgs) lib;};}
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
        osFlakePath = toString ./.;
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
