import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Niri

import "./modules/"

ShellRoot{
  id: root

  Niri {
    id: niri
    Component.onCompleted: connect()

    onConnected: console.info("Bar: Connected to Niri")
    onErrorOccurred: (error) => console.error("Niri Error:", error)
  }

  LazyLoader { active: true; component: Bar{} }
}
