import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
  id: bar
  anchors {
    top: true
    left: true
    right: true
  }
  implicitHeight: 30
  color: "transparent"

  Rectangle {
    anchors.fill: parent
    color: "#222222"
    bottomLeftRadius: 20
    bottomRightRadius: 20

    RowLayout {
      anchors {
        left: parent.left
        leftMargin: 25
      }

      Loader { active: true; sourceComponent: Workspaces {} }
    }

    RowLayout {
      anchors {
        horizontalCenter: parent.horizontalCenter
        verticalCenter: parent.verticalCenter
      }

      Text {
        text: niri.focusedWindow?.title ?? ""
        font.family: "FiraCode Nerd Font Mono"
        font.pixelSize: 16
        color: "#999999"
      }
    }

    RowLayout {
      anchors {
        verticalCenter: parent.verticalCenter
        right: parent.right
        rightMargin: 25
      }

      spacing: 10

      Loader { active: true; sourceComponent: Time {} }
    }
  }
}
