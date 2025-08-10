{config, ...}: {
  user = "sophia";
  osFlakeLocation = "${config.homeDir}/Projects/nix-config";

  locale = {
    locale = "en_GB.UTF-8";
    timeZone = "Europe/London";
    keyMap = "uk";
  };

  razor.enable = false;
  fonts.all.enable = true;
}
