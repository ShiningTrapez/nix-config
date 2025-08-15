#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

fileName="${1-}"

: "${out:?}"

fontDir="$out/share/fonts"

mkdir -p \
  "$fontDir/truetype" \
  "$fontDir/opentype" \
  "$fontDir/type1" \
  "$fontDir/pcf" \
  "$fontDir/bdf" \
  "$fontDir/misc"

getDestDir() {
  local path="$1"
  local baseName="${path##*/}"
  local baseLower="${baseName,,}"

  case "$baseLower" in
    *.ttf|*.ttc) echo "$fontDir/truetype" ;;
    *.otf|*.otc) echo "$fontDir/opentype" ;;
    *.pfb|*.pfa|*.afm|*.pfm) echo "$fontDir/type1" ;;
    *.pcf|*.pcf.gz) echo "$fontDir/pcf" ;;
    *.bdf|*.bdf.gz) echo "$fontDir/bdf" ;;
    *.woff|*.woff2) echo "$fontDir/misc" ;;
    *) echo "$fontDir/misc" ;;
  esac
}

if [[ -n "$fileName" ]]; then
  # Single-file mode: require $src to be a regular file
  : "${src:?src must be set to a font file when using single-file mode}"
  if [[ ! -f "$src" ]]; then
    echo "error: src '$src' is not a regular file" >&2
    exit 1
  fi
  install -Dm444 "$src" "$(getDestDir "$fileName")/$fileName"
else
  # Bulk mode: scan ${src:-.} (default to current directory)
  root="${src:-.}"
  find "$root" -type f \
    \( -iname '*.ttf' -o -iname '*.ttc' \
       -o -iname '*.otf' -o -iname '*.otc' \
       -o -iname '*.pfb' -o -iname '*.pfa' -o -iname '*.afm' -o -iname '*.pfm' \
       -o -iname '*.pcf' -o -iname '*.pcf.gz' \
       -o -iname '*.bdf' -o -iname '*.bdf.gz' \
       -o -iname '*.woff' -o -iname '*.woff2' \) \
    -print0 |
  while IFS= read -r -d '' f; do
    install -Dm444 "$f" "$(getDestDir "$f")/$(basename "$f")"
  done
fi
