{
  description = "NixOS Config Flake - Rainbow Machine";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    qml-niri = {
			url = "github:imiric/qml-niri/main";
			inputs.nixpkgs.follows = "nixpkgs";
			inputs.quickshell.follows = "quickshell";
		};
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
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

    nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem rec {
      system = "x86_64-linux";
      specialArgs = {
        inherit lib inputs system;

        # TODO Don't hardcode this
        osFlakePath = "/home/sophia/Projects/nix-config";
      };

      modules = [
        ./overlays.nix
        ./hardware/${hostname}.nix
        ./config
        ./system

        home-manager.nixosModules.home-manager
        {
          home-manager.extraSpecialArgs = {inherit inputs system;};
        }

        inputs.niri.nixosModules.niri

        ./modules
      ];
    };
  };
}
