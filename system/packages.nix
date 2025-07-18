{ pkgs, ...}: {
  hardware.opentabletdriver.enable = true;

  environment.systemPackages = with pkgs; [
    dialog
    ((ffmpeg-full.override { withUnfree = true; }).overrideAttrs (_: { doCheck = false; }))
    glibcLocales # https://github.com/NixOS/nixpkgs/issues/8398#issuecomment-186832814
    appimage-run
    corefonts

    # Sound
    pavucontrol
    pipewire

    # Needed for some GTK Apps
    adwaita-icon-theme
  ];

  # Make App Images directly executable
  boot.binfmt.registrations.appimage = {
    wrapInterpreterInShell = false;
    interpreter = "${pkgs.appimage-run}/bin/appimage-run";
    recognitionType = "magic";
    offset = 0;
    mask = ''\xff\xff\xff\xff\x00\x00\x00\x00\xff\xff\xff'';
    magicOrExtension = ''\x7fELF....AI\x02'';
  };
}
