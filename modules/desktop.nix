{
  inputs,
  pkgs,
  ...
}: {
  programs.niri = {
    settings = {
      environment."NIXOS_OZONE_WL" = "1";
    };
  };

  programs.waybar = {
    systemd.enable = true;
    settings.mainBar.layer = "top";
  };

  home.packages = with pkgs; [
    niri
    waybar
    swaylock
    mako
    alacritty-graphics
    fuzzel
    awww

    (inputs.quickshell.packages.${stdenv.hostPlatform.system}.default.withModules [
      inputs.qml-niri.packages.${stdenv.hostPlatform.system}.default
      qt6.qtwayland
      qt6.qt5compat
    ])
  ];
}
