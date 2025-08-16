{
  config,
  inputs,
  ...
}: let
  inherit (config) user;
  inherit (config) homeDir;
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

      imports = [
        ./atuin.nix
        ./copyq.nix
        ./dconf.nix
        ./direnv.nix
        ./editorconfig.nix
        ./emacs.nix
        ./fzf.nix
        ./git.nix
        ./kitty.nix
        ./lsd.nix
        ./packages.nix
        ./starship.nix
        ./vicinae
        ./zsh
      ];

      programs.home-manager.enable = true;
    };
  };
}
