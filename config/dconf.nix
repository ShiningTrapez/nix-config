{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    dconf-editor
  ];

  dconf = with lib.hm.gvariant; {
    enable = true;
    settings = {
      "org/gnome/settings-daemon/plugins/power" = {
        sleep-inactive-ac-type = "shutdown";
        sleep-inactive-ac-timeout = 60 * 60 * 2;
        power-button-action = "interactive";
      };

      "apps/seahorse/listing" = {
        keyrings-selected = ["openssh:///home/sophia/.ssh"];
      };

      "org/gnome/desktop/a11y/applications" = {
        screen-reader-enabled = false;
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        cursor-size = 24;
        cursor-theme = "Adwaita";
        enable-animations = true;
        font-name = "Monoid Nerd Font Mono,  10";
        icon-theme = "breeze-dark";
        scaling-factor = mkUint32 1;
        text-scaling-factor = 1.0;
        toolbar-style = "text";
        clock-show-weekday = true;
      };

      "org/gnome/desktop/wm/preferences" = {
        button-layout = "icon:minimize,maximize,close";
      };

      "org/gtk/settings/file-chooser" = {
        date-format = "regular";
        location-mode = "path-bar";
        show-hidden = false;
        show-size-column = true;
        show-type-column = true;
        sort-column = "name";
        sort-directories-first = false;
        sort-order = "ascending";
        type-format = "category";
      };
    };
  };
}
