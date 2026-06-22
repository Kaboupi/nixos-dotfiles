import Quickshell
import QtQuick
import QtQuick.Layouts
import Quickshell.Io

Item {
    id: powerMenu

    property var anchorWindow: null
    signal dismiss()

    visible: false
    width: 270
    height: grid.implicitHeight + 28
    x: anchorWindow ? anchorWindow.width - width - 20 : 0
    y: anchorWindow ? anchorWindow.height + 5 : 0

    Rectangle {
        anchors.fill: parent
        color: "#313244"
        radius: 10
        border.color: "#45475a"
        border.width: 1

        GridLayout {
            id: grid
            anchors.fill: parent
            anchors.margins: 14
            columns: 2
            columnSpacing: 10
            rowSpacing: 10

            Repeater {
                model: ListModel {
                    ListElement { label: "Lock"; icon: "󰍁"; clr: "#89b4fa"; cmdIdx: 0 }
                    ListElement { label: "Sleep"; icon: "󰤄"; clr: "#b4befe"; cmdIdx: 1 }
                    ListElement { label: "Reboot"; icon: "󰜉"; clr: "#f9e2af"; cmdIdx: 2 }
                    ListElement { label: "Shutdown"; icon: "⏻"; clr: "#f38ba8"; cmdIdx: 3 }
                }

                Rectangle {
                    id: pBtn
                    required property int index
                    required property string label
                    required property string icon
                    required property string clr
                    required property int cmdIdx

                    width: 115
                    height: 80
                    radius: 10
                    color: pwrMa.containsMouse ? "#45475a" : "#181825"
                    border.color: pwrMa.containsMouse ? pBtn.clr : "transparent"
                    border.width: 1

                    Behavior on color { ColorAnimation { duration: 150 } }

                    ColumnLayout {
                        anchors.centerIn: parent
                        spacing: 6
                        Text { text: pBtn.icon; color: pBtn.clr; font.pointSize: 18; font.bold: true; Layout.alignment: Qt.AlignHCenter }
                        Text { text: pBtn.label; color: "#cdd6f4"; font.pointSize: 10; Layout.alignment: Qt.AlignHCenter }
                    }

                    MouseArea {
                        id: pwrMa
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            var cmds = [["hyprlock"], ["systemctl", "suspend"], ["systemctl", "reboot"], ["systemctl", "poweroff"]];
                            pwrProc.command = cmds[pBtn.cmdIdx];
                            pwrProc.start();
                        }
                    }

                    Process { id: pwrProc; command: []; running: false }
                }
            }
        }
    }
}
