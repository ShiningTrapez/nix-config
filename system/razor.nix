{
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
in {
  options.razor.enable = mkEnableOption "Razor";

  config = lib.mkIf config.razor.enable {
    hardware.openrazer.enable = true;

    environment.systemPackages = with pkgs; [
      openrazer-daemon
      polychromatic
      input-remapper
    ];

    users.users.${config.user} = {
      extraGroups = ["openrazer"];
    };
  };
}
