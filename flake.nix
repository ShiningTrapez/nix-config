{
  description = "NixOS Config Flake - Rainbow Machine";
  
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable?shallow=1";
    nixpkgs-24.url = "github:NixOS/nixpkgs/nixos-24.11?shallow=1";

    home-manager = {
      url = "github:nix-community/home-manager/master?shallow=1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, home-manager, ... }@inputs: 
    let
      hostname = "RainbowMachine";
      filesIn = dir: (map (fname: dir + "/${fname}") 
        (builtins.attrNames (builtins.readDir dir)));
    in {
      nixosConfigurations.${hostname} = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs.inputs = inputs;

        modules = (filesIn ./system) ++ [
          ./hardware/${hostname}.nix

          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.backupFileExtension = "bak";

            home-manager.extraSpecialArgs.inputs = inputs;
            home-manager.users.sophia = import ./sophia.nix;
          }
        ];
      };
    };
}