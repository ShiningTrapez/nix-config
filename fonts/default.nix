# https://discourse.nixos.org/t/fontconfig-error-no-writable-cache-directories/34447

{ pkgs }: with pkgs; {
  letteromatic = stdenvNoCC.mkDerivation {
    pname = "Letteromatic";
    version = "1.0";
    src = fetchzip {
      url = "https://dl.dafont.com/dl/?f=letter_o_matic";
      hash = "sha256-yjJAt2w+wC1vpQMn6xCReHEu6g6Xr3JRtRjmOG/J8Gs=";
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
}
