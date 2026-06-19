import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts

PanelWindow {
    id: root
    anchors.top: true
    anchors.left: true
    anchors.right: true
    height: 35
    
    color: "#1e1e2e" // Catppuccin Mocha Base

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 15

        Text {
            text: "NixOS Homelab"
            color: "#cdd6f4"
            font.bold: true
            font.pointSize: 11
        }

        Item { Layout.fillWidth: true }

        RowLayout {
            spacing: 8

            // Custom Interactive Wi-Fi Button
            HardwareButton {
                id: wifiButton
                iconText: ""
                
                Process {
                    id: wifiStatusProcess
                    command: ["nmcli", "-t", "-f", "ACTIVE,SSID", "dev", "wifi"]
                    running: true
                    
                    // Correct Quickshell way: Attach a SplitParser to handle incoming stdout lines
                    stdout: SplitParser {
                        onRead: data => {
                            var line = data.toString().trim();
                            if (line.startsWith("yes:")) {
                                wifiButton.statusText = line.split(":")[1];
                                wifiButton.active = true;
                            } else if (!wifiButton.active) {
                                wifiButton.statusText = "Disconnected";
                            }
                        }
                    }
                }

                mouseArea.onClicked: (mouse) => {
                    if (mouse.button === Qt.RightButton) {
                        wifiToggle.start();
                    } else {
                        wifiMenu.start();
                    }
                }

                Process { id: wifiToggle; command: ["nmcli", "radio", "wifi", "toggle"] }
                Process { id: wifiMenu; command: ["nm-connection-editor"] }
            }

            // Custom Interactive Bluetooth Button
            HardwareButton {
                id: bluetoothButton
                iconText: ""

                Process {
                    id: btStatusProcess
                    command: ["bluetoothctl", "show"]
                    running: true
                    
                    stdout: SplitParser {
                        onRead: data => {
                            var line = data.toString();
                            if (line.includes("Powered: yes")) {
                                bluetoothButton.active = true;
                                bluetoothButton.statusText = "On";
                            } else if (line.includes("Powered: no")) {
                                bluetoothButton.active = false;
                                bluetoothButton.statusText = "Off";
                            }
                        }
                    }
                }

                mouseArea.onClicked: (mouse) => {
                    if (mouse.button === Qt.RightButton) {
                        btToggle.start();
                    } else {
                        btMenu.start();
                    }
                }

                Process { id: btToggle; command: ["bash", "-c", "bluetoothctl show | grep -q 'Powered: yes' && bluetoothctl power off || bluetoothctl power on"] }
                Process { id: btMenu; command: ["blueman-manager"] }
            }
        }
    }
}
