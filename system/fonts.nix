{pkgs, lib, ...}: let
  nerd-fonts = (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts));
in {
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    packages = with pkgs; [
      lmodern # LaTeX
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      meslo-lgs-nf
    ] ++ nerd-fonts;

    fontconfig = {
      defaultFonts = {
        serif = ["Fira Code"];
        sansSerif = ["Fira Code"];
        monospace = ["Fira Code"];
      };
    };
  };
}
