{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (pkgs) bash fetchzip stdenvNoCC;

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
        runHook preInstall;
        ${bash}/bin/bash ${./fontInstall.sh}
        runHook postInstall
      '';
    };

  fontPkgs = {
    gothicpixels = dafont "gothicpixels" "sha256-XwiDQv8hyyBB6y8G9i9wbr+qv1x2CTRjYgFKXZSw3Qk=";
    letter_o_matic = dafont "letter_o_matic" "sha256-yjJAt2w+wC1vpQMn6xCReHEu6g6Xr3JRtRjmOG/J8Gs=";
    handwriting_draft = dafont "handwriting_draft" "sha256-GNZU95NekmSBLjMndh6FDnEAmpl310XOYnfYiAfnHWI=";
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
      letter_o_matic.enable = mkEnableOption "LetterOMatic";
      handwriting_draft.enable = mkEnableOption "HandwritingDraft";
      all.enable = mkEnableOption "All Fonts";
    };
  };

  config = {
    fonts.packages = enabledFontPackages;
  };
}
