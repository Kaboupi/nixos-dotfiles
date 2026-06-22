import QtQuick
import QtQuick.Layouts

Rectangle {
    id: control

    property string iconText: ""
    property string label: ""
    property bool active: false
    property bool menuOpen: false
    property alias mouseArea: clickTarget

    signal clicked(var mouse)

    implicitWidth: layoutRow.implicitWidth + 16
    implicitHeight: 28
    radius: 6
    color: menuOpen ? "#313244" : (active ? "#45475a" : "transparent")
    border.color: active ? "#89b4fa" : "transparent"
    border.width: 1

    Behavior on color {
        ColorAnimation { duration: 150 }
    }

    RowLayout {
        id: layoutRow
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: control.iconText
            color: control.active ? "#89b4fa" : "#6c7086"
            font.pointSize: 12
        }

        Text {
            text: control.label
            color: "#cdd6f4"
            font.pointSize: 10
            visible: control.label.length > 0
        }
    }

    MouseArea {
        id: clickTarget
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true
        onClicked: (mouse) => control.clicked(mouse)
        onEntered: control.opacity = 0.85
        onExited: control.opacity = 1.0
    }
}
