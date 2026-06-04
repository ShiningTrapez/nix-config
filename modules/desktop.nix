{
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
  ];
}
