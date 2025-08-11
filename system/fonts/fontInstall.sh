#!/usr/bin/env bash

copy_fonts() {
  local dest="$1"; shift
  local pattern

  for pattern in "$@"; do
    find "${src:?}" -type f -iname "$pattern" -exec cp -f -t "$dest" -- {} +
  done
}

fontDir="${out:?}/share/fonts"

mkdir -p "$fontDir/truetype" "$fontDir/opentype" "$fontDir/type1" "$fontDir/pcf" "$fontDir/bdf"

# TrueType (TTF, TTC)
copy_fonts "$fontDir/truetype" '*.ttf' '*.ttc'

# OpenType (OTF)
copy_fonts "$fontDir/opentype" '*.otf'

# Type 1 (PFB/PFA + AFM)
copy_fonts "$fontDir/type1" '*.pfb' '*.pfa' '*.afm'

# Bitmap (PCF, BDF)
copy_fonts "$fontDir/pcf" '*.pcf' '*.pcf.gz'
copy_fonts "$fontDir/bdf" '*.bdf' '*.bdf.gz'
