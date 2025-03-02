{pkgs, ...}: {
  # CVE-2024-47176
  # services.printing.browsed.enable = false;

  # TODO: Figure out how to override branch
  hardware.ckb-next = {
    enable = true;
  };

  programs.zsh.enable = true;

  # File Explorer
  # programs.thunar.enable = true;
  programs.xfconf.enable = true;

  # services.gvfs.enable = true; # Mount, Trash etc.
  # services.tumbler.enable = true; # Thumbnail Support

  # Desktop
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;
  # services.desktopManager.plasma6.enable = true;

  services.xserver = {
    desktopManager.gnome.enable = true;
  };

  environment.gnome.excludePackages = (with pkgs; [
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
  ]);

  environment.systemPackages = with pkgs; [
    gnomeExtensions.appindicator
    adwaita-icon-theme
  ];

  services.udev.packages = with pkgs; [
    gnome-settings-daemon
  ];

  users.users.sophia = {
    shell = pkgs.zsh;
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

  # Steam
  programs.steam.enable = true;
}
