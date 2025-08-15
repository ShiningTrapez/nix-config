{pkgs, ...}: {
  programs.jq.enable = true;

  home.packages = with pkgs; [
    bat
    gimp-with-plugins
    blender
    steam-acf
    webcamoid
    google-chrome
    ungoogled-chromium
    firefox-beta
    microsoft-edge
    protonup-qt
    protontricks

    zeal
    kubectl

    imagemagick
    vlc
    curl
    gcc
    dunst
    openssl
    seahorse # GUI for Gnome Keyring

    fnm
    macchina
    onefetch
    lolcat
    flameshot
    unzip
    nixd
    niv
    comma
    zip

    libreoffice-qt
    hunspell
    hunspellDicts.en_GB-large

    packwiz

    texlive.combined.scheme-full
    prismlauncher
    jetbrains.idea-community

    # (discord-ptb.override {
    # withOpenASAR = true;
    # withVencord = true;
    # })
    vesktop # Discord Alt Client
    slack
    teams-for-linux
    vscode

    # Screenshots
    grim
    slurp
    swappy

    zed-editor

    # https://discourse.nixos.org/t/issue-building-linux-kernel-modules-after-flake-update/62322/15
    nixVersions.latest
  ];
}
