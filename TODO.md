# TODO - System Config

* Set up Emacs
* Migrate away from ~~Plasma~~ Gnome
  * Possibly Wayland + Rivers + Waybar + Rofi?
  * Niri + Quickshell + Noctalia
* Manage Firefox config
* Fix or Migrate away from SDDM (Sugar Dark not loading)
* Use Stylix

# Misc
* Use `NIRI_SOCKET=/run/user/1000/$(ls /run/user/$(id -u)/niri*.sock) niri msg action spawn -- alacritty`
to launch a shell within Niri when testing
* https://codeberg.org/LGFae/awww
  Use `awww-daemon` `Ctrl-Z` `bg` to start the Wallpaper Server
