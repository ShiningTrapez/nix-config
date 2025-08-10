{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (pkgs) stdenvNoCC fetchzip;

  dafont = name: hash:
    stdenvNoCC.mkDerivation {
      pname = name;
      version = "1.0";
      src = fetchzip {
        url = "https://dl.dafont.com/dl/?f=${name}";
        inherit hash;
        extension = "zip";
        stripRoot = false;
      };

      installPhase = ''
        runHook preInstall

        mkdir -p $out/share/fonts/truetype/
        cp -r $src/*.ttf $out/share/fonts/truetype/

        runHook postInstall
      '';
    };

  fontPkgs = {
    gothicpixels = dafont "gothicpixels" "sha256-XwiDQv8hyyBB6y8G9i9wbr+qv1x2CTRjYgFKXZSw3Qk=";
    letteromatic = dafont "letter_o_matic" "sha256-yjJAt2w+wC1vpQMn6xCReHEu6g6Xr3JRtRjmOG/J8Gs=";
  };

  enabledNames =
    builtins.filter
    (
      name:
        (config.fonts.all.enable or false)
        || ((builtins.getAttr name config.fonts).enable || false)
    )
    (builtins.attrNames fontPkgs);

  enabledFontPackages = builtins.map (name: builtins.getAttr name fontPkgs) enabledNames;
in {
  options = {
    fonts = {
      gothicpixels.enable = mkEnableOption "GothicPixels";
      letteromatic.enable = mkEnableOption "Letteromatic";
      all.enable = mkEnableOption "All Fonts";
    };
  };

  config = {
    fonts.packages = enabledFontPackages;
  };
}
