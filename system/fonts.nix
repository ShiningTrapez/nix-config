{pkgs, lib, ...}: with pkgs; let
  custom = callPackage ../fonts {};
  nerdFonts = (builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts));
in {
  environment.systemPackages = [
    corefonts
    fontconfig
  ];

  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;

    fontconfig = {
      enable = true;
      defaultFonts = {
        serif = ["Fira Code"];
        sansSerif = ["Fira Code"];
        monospace = ["Fira Code"];
      };
      useEmbeddedBitmaps = true;
    };

    packages = with pkgs; [
      lmodern # LaTeX
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      liberation_ttf
      meslo-lgs-nf
      custom.gothicpixels
      custom.letteromatic
    ] ++ nerdFonts;
  };
}
