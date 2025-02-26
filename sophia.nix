{...}: let
  filesIn = dir: (map (fname: dir + "/${fname}") (builtins.attrNames (builtins.readDir dir)));
in {
  home.stateVersion = "23.11";

  home.username = "sophia";
  home.homeDirectory = "/home/sophia";

  imports = (filesIn ./programs) ++ (filesIn ./config);

  programs.home-manager.enable = true;
}
