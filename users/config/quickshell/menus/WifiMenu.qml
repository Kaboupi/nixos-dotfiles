import Quickshell
import QtQuick
import QtQuick.Layouts

Item {
    id: wifiMenu

    property var anchorWindow: null
    signal dismiss()

    visible: false
    width: 340
    height: Math.min(400, networkList.height + 140)
    x: anchorWindow ? anchorWindow.width - width - 180 : 0
    y: anchorWindow ? anchorWindow.height + 5 : 0

    property string selectedSSID: ""
    property bool showPassword: false

    Rectangle {
        anchors.fill: parent
        color: "#313244"
        radius: 10
        border.color: "#45475a"
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 10

            RowLayout {
                Text {
                    text: "Wi-Fi"
                    color: "#cdd6f4"
                    font.bold: true
                    font.pointSize: 12
                    Layout.fillWidth: true
                }

                Rectangle {
                    width: 60
                    height: 28
                    radius: 14
                    color: wifiService.wifiEnabled ? "#a6e3a1" : "#45475a"

                    Text {
                        anchors.centerIn: parent
                        text: wifiService.wifiEnabled ? "On" : "Off"
                        color: "#cdd6f4"
                        font.pointSize: 10
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: wifiService.toggleWifi()
                        cursorShape: Qt.PointingHandCursor
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: "#45475a" }

            ListView {
                id: networkList
                Layout.fillWidth: true
                Layout.fillHeight: true
                clip: true
                model: wifiService.networks

                delegate: Rectangle {
                    width: networkList.width
                    height: 52
                    radius: 6
                    color: modelData.active ? "#45475a" : (nMa.containsMouse ? "#45475a" : "transparent")

                    RowLayout {
                        anchors.fill: parent
                        anchors.leftMargin: 8
                        anchors.rightMargin: 8
                        spacing: 10

                        Text {
                            text: modelData.active ? "󰤨" : (modelData.signal > 75 ? "󰤨" : modelData.signal > 50 ? "󰤥" : modelData.signal > 25 ? "󰤢" : "󰤟")
                            color: modelData.active ? "#89b4fa" : "#6c7086"
                            font.pointSize: 14
                        }

                        ColumnLayout {
                            Layout.fillWidth: true
                            spacing: 2

                            Text {
                                text: modelData.ssid
                                color: "#cdd6f4"
                                font.pointSize: 11
                                elide: Text.ElideRight
                                Layout.fillWidth: true
                            }

                            Text {
                                text: modelData.active ? "Connected" : (modelData.security ? "Secured" : "Open")
                                color: "#a6adc8"
                                font.pointSize: 9
                            }
                        }

                        Rectangle {
                            width: 24
                            height: 24
                            radius: 12
                            color: "transparent"
                            visible: modelData.active

                            Text {
                                anchors.centerIn: parent
                                text: "✓"
                                color: "#a6e3a1"
                                font.pointSize: 12
                            }
                        }
                    }

                    MouseArea {
                        id: nMa
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            if (modelData.active) {
                                wifiService.disconnect();
                            } else if (modelData.security) {
                                wifiMenu.selectedSSID = modelData.ssid;
                                wifiMenu.showPassword = true;
                            } else {
                                wifiService.connect(modelData.ssid, "");
                            }
                        }
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: "#45475a"; visible: wifiMenu.showPassword }

            ColumnLayout {
                visible: wifiMenu.showPassword
                spacing: 8

                Text {
                    text: "Connect to " + wifiMenu.selectedSSID
                    color: "#cdd6f4"
                    font.pointSize: 10
                }

                RowLayout {
                    spacing: 8

                    Rectangle {
                        Layout.fillWidth: true
                        height: 32
                        radius: 6
                        color: "#45475a"
                        border.color: "#6c7086"
                        border.width: 1

                        TextInput {
                            id: passwordInput
                            anchors.fill: parent
                            anchors.margins: 8
                            color: "#cdd6f4"
                            echoMode: TextInput.Password
                            font.pointSize: 10
                            clip: true
                            selectByMouse: true
                            selectionColor: "#89b4fa"

                            Text {
                                anchors.fill: parent
                                anchors.verticalCenter: parent.verticalCenter
                                text: "Password"
                                color: "#6c7086"
                                font.pointSize: 10
                                visible: !passwordInput.text && !passwordInput.activeFocus
                            }
                        }
                    }

                    Rectangle {
                        width: 60
                        height: 32
                        radius: 6
                        color: "#89b4fa"

                        Text {
                            anchors.centerIn: parent
                            text: "Connect"
                            color: "#1e1e2e"
                            font.pointSize: 10
                            font.bold: true
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                wifiService.connect(wifiMenu.selectedSSID, passwordInput.text);
                                wifiMenu.showPassword = false;
                                passwordInput.text = "";
                            }
                            cursorShape: Qt.PointingHandCursor
                        }
                    }

                    Rectangle {
                        width: 32
                        height: 32
                        radius: 6
                        color: "#45475a"

                        Text {
                            anchors.centerIn: parent
                            text: "✕"
                            color: "#6c7086"
                            font.pointSize: 12
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                wifiMenu.showPassword = false;
                                passwordInput.text = "";
                            }
                            cursorShape: Qt.PointingHandCursor
                        }
                    }
                }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: "#45475a" }

            Rectangle {
                Layout.fillWidth: true
                height: 28
                radius: 6
                color: refMa.containsMouse ? "#45475a" : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: "Refresh"
                    color: "#cdd6f4"
                    font.pointSize: 10
                }

                MouseArea {
                    id: refMa
                    anchors.fill: parent
                    onClicked: {
                        wifiService.rescan();
                    }
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
