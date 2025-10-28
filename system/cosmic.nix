{
  config,
  pkgs,
  ...
}: {
  services.displayManager = {
    cosmic-greeter.enable = true;

    autoLogin = {
      enable = true;
      user = config.user;
    };
  };

  services.desktopManager.cosmic.enable = true;

  environment = {
    cosmic.excludePackages = with pkgs; [
      cosmic-edit
      cosmic-player
    ];

    sessionVariables.COSMIC_DATA_CONTROL_ENABLED = 1;
  };

  programs.firefox.preferences = {
    "widget.gtk.libadwaita-colors.enabled" = false;
  };
}
