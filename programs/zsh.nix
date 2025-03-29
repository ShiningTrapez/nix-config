{
  config,
  pkgs,
  ...
}: let
  xdg-config-dir = "${config.home.homeDirectory}/.config";

  projects = "${config.home.homeDirectory}/Projects";
  work = "${config.home.homeDirectory}/Work";
  work-cert = "${config.home.homeDirectory}/morrip87.pem";

  ls = "${pkgs.lsd}/bin/lsd";
in {
  programs.zsh = {
    enable = true;
    autocd = true;
    cdpath = [
      "${projects}"
      "${work}"
      "${work}/tv-client/packages"
      "${work}/tv-client/apps"
      "${xdg-config-dir}"
    ];
    dotDir = ".config/zsh";
    autosuggestion.enable = true;
    enableCompletion = true;

    sessionVariables = {
      EDITOR = "code --wait";
      BBC_CERT_PATH = "${work-cert}";
      CLIENT_CERT = "${work-cert}";
      # _JAVA_OPTIONS = "-Dawt.useSystemAAFontSettings=lcd";

      # https://github.com/tauri-apps/tauri/issues/9304#issuecomment-2028409103
      WEBKIT_DISABLE_DMABUF_RENDERER = 1;

      # https://github.com/NixOS/nixpkgs/issues/8398#issuecomment-251287741
      LANG = "en_GB.UTF-8";
      LC_ALL = "en_GB.UTF-8";

      # Puppeteer is awkward on Nix
      PUPPETEER_SKIP_DOWNLOAD = 1;
    };

    shellAliases = {
      restart = "shutdown -r now";
      syntax = "bat";
      temperature = "echo $(( $(cat /sys/class/thermal/thermal_zone*/temp) / 1000 )) | sed 's/$/C/'";
      gpu-temperature = "nvidia-smi --query-gpu=temperature.gpu --format csv | tail -n1 | sed 's/$/C/'";
      system-temperature = "echo \"CPU: $(temperature)\nGPU: $(gpu-temperature)\"";
      gpu-info = "nvidia-smi --query-gpu=timestamp,name,temperature.gpu,utilization.gpu,utilization.memory,memory.total,memory.free,memory.used --format=csv -l 5";

      tree = "${ls} --tree";
      fix-audio = "systemctl --user restart pipewire.service";
      fix-internet = "sudo systemctl restart NetworkManager";
      back = "cd $OLD_PWD";
      work = "cd ${work}";
      projects = "cd ${projects}";

      # Workaround for non FHS Patched Binaries installed by FNM
      # TODO: Use nix-ld
      npm = "steam-run npm";
      pnpm = "steam-run pnpm";
      yarn = "steam-run yarn";
      node = "steam-run node";
      corepack = "steam-run corepack";
    };

    plugins = with pkgs; [
      {
        name = "zsh-syntax-highlighting";
        src = fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
        file = "zsh-syntax-highlighting.zsh";
      }
    ];

    initExtra = builtins.readFile ../shell/zsh.zsh;
  };

  home.file."${config.home.homeDirectory}/.config/zsh/scripts/" = {
    source = ../scripts;
    recursive = true;
  };
}
