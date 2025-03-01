{
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    (final: prev: {
      nur = import inputs.nur {
        nurpkgs = prev;
        pkgs = prev;
        repoOverrides = { bandithedoge = import inputs.bandithedoge-nur { pkgs = prev; }; };
      };
    })
  ];
}
