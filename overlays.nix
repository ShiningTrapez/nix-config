{pkgs, ...}: {
  nixpkgs.overlays = [
    (_: prev: {
      sddm-sugar-dark = (pkgs.libsForQt5.callPackage ./packages/sddm-sugar-dark.nix {
        configOverrides = pkgs.writeText "custom-theme.conf" ''
          [General]
          # Force default
          ScreenWidth=
          ScreenHeight=
        '';
      });

      vicinae = pkgs.callPackage ./packages/vicinae.nix {};
    })
  ];
}
