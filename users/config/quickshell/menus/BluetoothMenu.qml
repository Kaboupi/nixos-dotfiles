import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: btMenu

    property var anchorWindow: null
    signal dismiss()

    visible: false
    width: 340
    height: Math.min(450, contentCol.implicitHeight + 28)
    x: anchorWindow ? anchorWindow.width - width - 480 : 0
    y: anchorWindow ? anchorWindow.height + 5 : 0

    Rectangle {
        anchors.fill: parent
        color: "#313244"
        radius: 10
        border.color: "#45475a"
        border.width: 1

        ColumnLayout {
            id: contentCol
            anchors.fill: parent
            anchors.margins: 14
            spacing: 10

            RowLayout {
                Text {
                    text: "Bluetooth"
                    color: "#cdd6f4"
                    font.bold: true
                    font.pointSize: 12
                    Layout.fillWidth: true
                }

                Rectangle {
                    width: 60
                    height: 28
                    radius: 14
                    color: btService.btPowered ? "#b4befe" : "#45475a"

                    Text {
                        anchors.centerIn: parent
                        text: btService.btPowered ? "On" : "Off"
                        color: "#cdd6f4"
                        font.pointSize: 10
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: btService.togglePower()
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: "#45475a" }

            Rectangle {
                Layout.fillWidth: true
                height: 28
                radius: 6
                color: scanMa.containsMouse ? "#45475a" : "transparent"
                visible: btService.btPowered

                Text {
                    anchors.centerIn: parent
                    text: btService.discovering ? "Stop Scan" : "Scan for Devices"
                    color: "#a6adc8"
                    font.pointSize: 10
                }

                MouseArea {
                    id: scanMa
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: { if (btService.discovering) btService.stopDiscovery(); else btService.startDiscovery(); }
                }
            }

            Repeater {
                model: btService.pairedDevices

                Rectangle {
                    required property var modelData
                    required property int index

                    Layout.fillWidth: true
                    height: 40
                    radius: 6
                    color: dMa.containsMouse ? "#45475a" : "transparent"

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        spacing: 8

                        Text { text: "󰂯"; color: "#b4befe"; font.pointSize: 14 }

                        ColumnLayout {
                            spacing: 0
                            Layout.fillWidth: true
                            Text { text: modelData.name; color: "#cdd6f4"; font.pointSize: 10; elide: Text.ElideRight; Layout.fillWidth: true }
                            Text { text: modelData.mac; color: "#6c7086"; font.pointSize: 8 }
                        }

                        Rectangle {
                            width: 70; height: 24; radius: 6
                            color: cMa.containsMouse ? "#b4befe" : "#45475a"
                            Text { anchors.centerIn: parent; text: "Connect"; color: "#cdd6f4"; font.pointSize: 9 }
                            MouseArea { id: cMa; anchors.fill: parent; hoverEnabled: true; onClicked: btService.connect(modelData.mac) }
                        }
                    }

                    MouseArea { id: dMa; anchors.fill: parent; acceptedButtons: Qt.RightButton; hoverEnabled: true; onClicked: (mouse) => { if (mouse.button === Qt.RightButton) btService.remove(modelData.mac); } }
                }
            }

            Repeater {
                model: btService.availableDevices

                Rectangle {
                    required property var modelData
                    required property int index

                    Layout.fillWidth: true
                    height: 40
                    radius: 6
                    color: pMa.containsMouse ? "#45475a" : "transparent"

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        spacing: 8

                        Text { text: "󰂰"; color: "#6c7086"; font.pointSize: 14 }

                        Text { text: modelData.name; color: "#cdd6f4"; font.pointSize: 10; Layout.fillWidth: true; elide: Text.ElideRight }

                        Rectangle {
                            width: 90; height: 24; radius: 6
                            color: pMa.containsMouse ? "#b4befe" : "#45475a"
                            Text { anchors.centerIn: parent; text: "Pair"; color: "#cdd6f4"; font.pointSize: 9 }
                            MouseArea { id: pMa; anchors.fill: parent; hoverEnabled: true; onClicked: btService.pair(modelData.mac) }
                        }
                    }
                }
            }
        }
    }
}
