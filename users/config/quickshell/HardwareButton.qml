import QtQuick
import QtQuick.Layouts

Rectangle {
    id: control
    property string iconText: ""
    property string statusText: "Loading..."
    property bool active: false
    property alias mouseArea: clickTarget

    implicitWidth: layoutRow.implicitWidth + 16
    implicitHeight: 26
    radius: 6
    color: active ? "#313244" : "#11111b"
    border.color: active ? "#89b4fa" : "transparent"
    border.width: 1

    RowLayout {
        id: layoutRow
        anchors.centerIn: parent
        spacing: 6

        Text {
            text: control.iconText
            color: control.active ? "#89b4fa" : "#6c7086"
            font.pointSize: 11
        }

        Text {
            text: control.statusText
            color: "#cdd6f4"
            font.pointSize: 10
        }
    }

    MouseArea {
        id: clickTarget
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        hoverEnabled: true
        onEntered: control.opacity = 0.8
        onExited: control.opacity = 1.0
    }
}
