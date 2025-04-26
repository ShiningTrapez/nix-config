{ pkgs, inputs, ... }: let
  nixpkgs-24 = inputs.nixpkgs-24.legacyPackages.x86_64-linux;
in {
  programs.jq.enable = true;

  home.packages = with pkgs; [
    vim-full

    bat
    nixpkgs-24.gimp-with-plugins
    nixpkgs-24.blender
    steam-acf
    webcamoid
    ungoogled-chromium
    nur.repos.bandithedoge.waterfox-bin
    protonup-qt
    protontricks

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

    texlive.combined.scheme-full
    prismlauncher

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
  ];
}
