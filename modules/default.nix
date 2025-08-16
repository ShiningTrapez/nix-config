{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (config) homeDir user;
  inherit (lib.custom) scanPaths;
in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "bak";

    extraSpecialArgs.inputs = {
      inherit inputs;
      nixosConfig = config;
    };

    users."${user}" = {
      home = {
        stateVersion = "23.11";
        username = user;
        homeDirectory = homeDir;
      };

      imports = scanPaths ./.;

      programs.home-manager.enable = true;
    };
  };
}
