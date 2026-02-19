{
  pkgs,
  lib,
  ...
}:
with pkgs; let
  inherit (lib.custom) scanPaths;
  nerdFonts = builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts);
in {
  imports = scanPaths ./.;

  environment.systemPackages = [
    corefonts
    fontconfig
    freetype
  ];

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Fira Code"];
        sansSerif = ["Fira Code"];
        monospace = ["Fira Code"];
      };
      useEmbeddedBitmaps = true;
    };

    packages = with pkgs;
      [
        lmodern # LaTeX
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        meslo-lgs-nf
        source-sans-pro
        source-sans
        roboto
        font-awesome
      ]
      ++ nerdFonts;
  };
}
