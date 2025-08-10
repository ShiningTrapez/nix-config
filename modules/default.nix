{
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
      ./zsh.nix
    ];

    programs.home-manager.enable = true;
  };
}
