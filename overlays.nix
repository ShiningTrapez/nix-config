_: {
  nixpkgs.overlays = [
    (_: prev:
      let pkgset = import ./packages { pkgs = prev; };
      in pkgset
    )
  ];
}
