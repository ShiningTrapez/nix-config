{ pkgs, ... }: with pkgs; {
  programs.zsh.enable = true;
  programs.xfconf.enable = true;

  services.gvfs.enable = true; # Mount, Trash etc.
  services.tumbler.enable = true; # Thumbnail Support

  # Desktop
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  services.xserver = {
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = [
    atomix # puzzle game
    cheese # webcam tool
    epiphany # web browser
    evince # document viewer
    geary # email reader
    gedit # text editor
    gnome-characters
    gnome-music
    gnome-photos
    gnome-terminal
    gnome-tour
    hitori # sudoku game
    iagno # go game
    tali # poker game
    totem # video player
  ];

  environment.systemPackages = [
    adwaita-icon-theme
    gnome-tweaks
    gnomeExtensions.appindicator
  ];

  services.udev.packages = [
    gnome-settings-daemon
  ];

  users.users.sophia = {
    shell = zsh;
    isNormalUser = true;
    description = "Sophia";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    uid = 1000;
  };

  security.sudo.wheelNeedsPassword = false;

  # TODO: Use unfreePredicate
  nixpkgs.config.allowUnfree = true;

  security.rtkit.enable = true;

  # Needed for SignIn in VSCode
  services.gnome.gnome-keyring.enable = true;

  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  programs.steam.enable = true;
}
