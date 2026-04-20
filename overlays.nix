{ inputs, ... }: {
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.default
    (
      _: prev: let
        pkgset = import ./packages {pkgs = prev;};
      in
        pkgset
    )
  ];
}
