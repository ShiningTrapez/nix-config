{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      # https://github.com/packwiz/packwiz/pull/326
      packwiz = prev.packwiz.overrideAttrs (old: {
        src = pkgs.fetchFromGitHub {
          owner = "Furglitch";
          repo = "packwiz";
          rev = "b781ae20ec519683c052c4fe0e0adbe68323cd3e";
          sha256 = "sha256-5FsI0Chmp+RQOf45zxZvLm2Y2ZBpN0nRlJ5gpKIvXu8=";
        };
      });
    })
  ];
}
