{lib, ...}: let
  inherit (lib.custom) scanPaths;
in {
  imports = scanPaths ./. ++ [ ./nix.nix ];
}
