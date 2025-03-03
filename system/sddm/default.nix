# https://github.com/Shados/nix-config-shared/blob/6bd16d7200920449694649d03f0b0ed2f0a45b02/nixos/apps/sddm/default.nix

{ config, lib, pkgs, ... }: {
  config = lib.mkIf config.services.displayManager.sddm.enable {
    services.displayManager.sddm.theme = "sugar-dark";
    environment.systemPackages = [
      (pkgs.libsForQt5.callPackage ./sugar-dark.nix {
        configOverrides = pkgs.writeText "custom-theme.conf" ''
          [General]
          # Force default
          ScreenWidth=
          ScreenHeight=
        '';
      })
    ];
  };
}
