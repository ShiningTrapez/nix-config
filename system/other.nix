{
  pkgs,
  config,
  ...
}:
with pkgs; {
  # nixpkgs.config.allowUnfreePredicate = pkg:
  #   builtins.elem (pkg.pname or "") [
  #     "steam"
  #     "nvidia-settings"
  #     "nvidia-persistenced"
  #     "slack"
  #   ];

  nixpkgs.config.allowUnfree = true;

  programs = {
    zsh.enable = true;
    xfconf.enable = true;

    # TODO: Home Manager
    steam.enable = true;
  };

  # Needed for Sway
  security = {
    polkit.enable = true;
    pam.loginLimits = [
      {
        domain = "@users";
        item = "rtprio";
        type = "-";
        value = 1;
      }
    ];
  };

  services = {
    gvfs.enable = true; # Mount, Trash etc.
    tumbler.enable = true; # Thumbnail Support

    # Desktop
    xserver.enable = true;
    displayManager.sddm.enable = true;

    desktopManager.gnome.enable = true;

    udev.packages = [
      gnome-settings-daemon
    ];

    # Needed for SignIn in VSCode
    gnome.gnome-keyring.enable = true;

    openssh.enable = true;
  };

  environment = {
    gnome.excludePackages = [
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
      file-roller
      snapshot
    ];

    systemPackages = [
      adwaita-icon-theme
      gnome-tweaks
      gnomeExtensions.appindicator
    ];
  };

  users.users."${config.user}" = {
    shell = zsh;
    isNormalUser = true;
    description = lib.toSentenceCase config.user;
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    uid = 1000;
  };

  security = {
    sudo.wheelNeedsPassword = false;
    rtkit.enable = true;
  };
}
