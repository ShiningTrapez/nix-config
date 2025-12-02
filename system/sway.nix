{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    grim # screenshots
    slurp # screenshots
    wl-clipboard # wl-copy and wl-paste
    mako # notifications
  ];

  # Needed for SignIn in VSCode
  services.gnome.gnome-keyring.enable = true;

  # enable Sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };
}
