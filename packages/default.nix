{pkgs,...}: let
  inherit (pkgs) libsForQt5 writeText callPackage;
in {
  sddm-sugar-dark = libsForQt5.callPackage ./sddm-sugar-dark.nix {
    configOverrides = writeText "custom-theme.conf" ''
      [General]
      # Force default
      ScreenWidth=
      ScreenHeight=
    '';
  };

  vicinae = callPackage ./vicinae.nix {};
}
