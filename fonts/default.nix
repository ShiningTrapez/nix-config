{ pkgs }: with pkgs; let
  dafont = name: hash: stdenvNoCC.mkDerivation {
    pname = name;
    version = "1.0";
    src = fetchzip {
      url = "https://dl.dafont.com/dl/?f=${name}";
      hash = hash;
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
in {
  gothicpixels = dafont "gothicpixels" "sha256-XwiDQv8hyyBB6y8G9i9wbr+qv1x2CTRjYgFKXZSw3Qk=";
  letteromatic = dafont "letter_o_matic" "sha256-yjJAt2w+wC1vpQMn6xCReHEu6g6Xr3JRtRjmOG/J8Gs=";
}
