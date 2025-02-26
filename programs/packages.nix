{
  pkgs,
  inputs,
  ...
}: let
  nixpkgs-24 = inputs.nixpkgs-24.legacyPackages.x86_64-linux;
in {
  programs.jq.enable = true;

  home.packages = with pkgs; [
    bat
    nixpkgs-24.gimp-with-plugins
    nixpkgs-24.blender
    steam-acf
    webcamoid
  ];
}
