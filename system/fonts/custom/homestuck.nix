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
    outputHash = "sha256-nliUIFEPiJBT0UUwiUs6c8QoXZTEBU4ivphqNQroygk=";
    outputHashMode = "recursive";

    dontUnpack = true;
    dontConfigure = true;
    dontBuild = true;

    installPhase = ''
      runHook preInstall

      tmpdir=$(mktemp -d)

      fetch_dir() {
        local url="$1"
        while IFS= read -r entry; do
          local name url_enc is_dir
          name=$(jq -r '.name' <<<"$entry")
          url_enc=$(jq -r '.url' <<<"$entry")
          is_dir=$(jq -r '.is_dir' <<<"$entry")
          [[ "$is_dir" == "true" ]] && continue
          curl -fsSL -o "$tmpdir/$name" "$url/''${url_enc#./}"
        done < <(curl --json "" -s "$url" | jq -c '.[]')
      }

      fetch_dir "${base}"
      fetch_dir "${base}/handwriting"
      fetch_dir "${base}/uncategorized"

      src="$tmpdir" bash ${./fontInstall.sh}

      runHook postInstall
    '';
  };
in {
  options.fonts.homestuck.enable = mkEnableOption "Homestuck Fonts";

  config = mkIf (config.fonts.homestuck.enable || (config.fonts.all.enable or false)) {
    fonts.packages = [homestuckFonts];
  };
}
