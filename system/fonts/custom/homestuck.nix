{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (pkgs) curl jq stdenvNoCC;
  base = "https://homestuck.net/resources/fonts";

  homestuckFonts = stdenvNoCC.mkDerivation {
    name = "homestuck-fonts";
    version = "2026-04-20";

    nativeBuildInputs = [curl jq];

    outputHashAlgo = "sha256";
    outputHash = "sha256-cmP4ppsvNP42yEJiHamfI8QDAlFr+pIh7duaFQIaHsQ=";
    outputHashMode = "recursive";

    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      mkdir -p "$out/share/fonts/truetype" "$out/share/fonts/opentype"

      fetch_dir() {
        local url="$1"
        while IFS= read -r entry; do
          local name url_enc is_dir lower dest
          name=$(jq -r '.name' <<<"$entry")
          url_enc=$(jq -r '.url' <<<"$entry")
          is_dir=$(jq -r '.is_dir' <<<"$entry")
          [[ "$is_dir" == "true" ]] && continue
          lower="''${name,,}"
          case "$lower" in
            *.ttf|*.ttc) dest="$out/share/fonts/truetype" ;;
            *.otf|*.otc) dest="$out/share/fonts/opentype" ;;
            *) continue ;;
          esac
          curl -fsSL -o "$dest/$name" "$url/''${url_enc#./}"
        done < <(curl --json "" -s "$url" | jq -c '.[]')
      }

      fetch_dir "${base}"
      fetch_dir "${base}/handwriting"
      fetch_dir "${base}/uncategorized"

      runHook postInstall
    '';
  };
in {
  options.fonts.homestuck.enable = mkEnableOption "Homestuck Fonts";

  config = mkIf (config.fonts.homestuck.enable || (config.fonts.all.enable or false)) {
    fonts.packages = [homestuckFonts];
  };
}
