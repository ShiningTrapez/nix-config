{lib, config, ...}: let
  inherit (lib) genAttrs mkOption types;
  locale = config.locale.locale;
in {
  options.locale = {
    locale = mkOption {
      type = types.str;
      default = "en_GB.UTF-8";
      description = "Default locale used by the System and Programs.";
      example = "en_US.UTF-8";
    };

    timeZone = mkOption {
      type = types.str;
      default = "Europe/London";
      description = "Default System Timezone.";
      example = "UTC";
    };

    keyMap = mkOption {
      type = types.str;
      default = "uk";
      description = "Console Keymap.";
      example = "us";
    };
  };

  config = {
    time.timeZone = config.locale.timeZone;

    i18n.defaultLocale = locale;

    i18n.extraLocaleSettings = genAttrs [
    "LC_ADDRESS"
    "LC_IDENTIFICATION"
    "LC_MEASUREMENT"
    "LC_MONETARY"
    "LC_NAME"
    "LC_NUMERIC"
    "LC_PAPER"
    "LC_TELEPHONE"
    "LC_TIME"
  ] (_: locale);

    console.keyMap = config.locale.keyMap;
  };
}
