import Quickshell
import Quickshell.Wayland
import QtQuick

PanelWindow {
    anchors.top: true
    anchors.left: true
    anchors.right: true
    implicitHeight: 40
    
    color: "#1e1e2e" // Minimal background color

    Text {
        anchors.centerIn: parent
        text: "Quickshell is Active"
        color: "#cdd6f4"
    }
}
