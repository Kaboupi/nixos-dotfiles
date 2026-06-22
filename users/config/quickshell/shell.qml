import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import "menus"
import "widgets"

PanelWindow {
    id: root
    anchors.top: true
    anchors.left: true
    anchors.right: true
    height: 35
    color: "#1e1e2e"

    property int activeMenu: 0

    function toggleMenu(type) {
        activeMenu = (activeMenu === type) ? 0 : type;
    }

    // Audio Service
    Item {
        id: audioService
        property real volume: 0.5
        property bool muted: false
        property bool ready: false

        Process {
            id: getVolProc
            command: ["wpctl", "get-volume", "@DEFAULT_AUDIO_SINK@"]
            running: false
            stdout: SplitParser {
                onRead: data => {
                    var line = data.toString().trim();
                    if (line.startsWith("Volume:")) {
                        var volStr = line.split(":")[1].trim();
                        audioService.muted = volStr.includes("[MUTED]");
                        volStr = volStr.replace("[MUTED]", "").trim();
                        audioService.volume = parseFloat(volStr);
                        audioService.ready = true;
                    }
                }
            }
        }

        Timer { interval: 2000; running: true; repeat: true; onTriggered: getVolProc.running = true }

        Process { id: setVolProc; command: []; running: false }

        function setVolume(level) {
            level = Math.max(0, Math.min(1, level));
            setVolProc.command = ["wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@", level.toString()];
            setVolProc.running = true;
            volume = level;
        }

        function toggleMute() {
            setVolProc.command = ["wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@", "toggle"];
            setVolProc.running = true;
            muted = !muted;
        }

        Component.onCompleted: getVolProc.running = true
    }

    // Wi-Fi Service
    Item {
        id: wifiService
        property bool wifiEnabled: true
        property string currentSSID: ""
        property var networks: []

        Process {
            id: wifiScanProc
            command: ["nmcli", "-t", "-f", "ACTIVE,SSID,SIGNAL,SECURITY", "dev", "wifi", "list"]
            running: false
            stdout: SplitParser {
                onRead: data => {
                    var line = data.toString().trim();
                    if (!line) return;
                    var parts = line.split(":");
                    if (parts.length < 3) return;
                    var active = parts[0] === "yes";
                    var ssid = parts[1];
                    var signal = parseInt(parts[2]) || 0;
                    var security = parts.length > 3 ? parts[3] : "";
                    if (active) { wifiService.currentSSID = ssid; wifiService.wifiEnabled = true; }
                    var found = false;
                    for (var i = 0; i < wifiService.networks.length; i++) {
                        if (wifiService.networks[i].ssid === ssid) {
                            wifiService.networks[i].signal = signal;
                            wifiService.networks[i].security = security;
                            wifiService.networks[i].active = active;
                            found = true;
                            break;
                        }
                    }
                    if (!found && ssid) wifiService.networks.push({ ssid: ssid, signal: signal, security: security, active: active });
                }
            }
        }

        Timer { interval: 5000; running: true; repeat: true; onTriggered: { wifiService.networks = []; wifiScanProc.running = true; } }

        Process { id: toggleWifiProc; command: []; running: false }
        function toggleWifi() { toggleWifiProc.command = ["nmcli", "radio", "wifi", wifiEnabled ? "off" : "on"]; toggleWifiProc.running = true; wifiEnabled = !wifiEnabled; }

        function connect(ssid, password) {
            var cmd = ["nmcli", "dev", "wifi", "connect", ssid];
            if (password) { cmd.push("password"); cmd.push(password); }
            connectProc.command = cmd; connectProc.running = true;
        }

        Process { id: connectProc; command: []; running: false }

        function disconnect() { disconnectProc.running = true; }
        Process { id: disconnectProc; command: ["nmcli", "device", "disconnect", "wlan0"]; running: false }

        function forget(ssid) { forgetProc.command = ["nmcli", "connection", "delete", ssid]; forgetProc.running = true; }
        Process { id: forgetProc; command: []; running: false }

        function rescan() { networks = []; wifiScanProc.running = true; }

        Component.onCompleted: wifiScanProc.running = true
    }

    // Bluetooth Service
    Item {
        id: btService
        property bool btPowered: false
        property bool discovering: false
        property var pairedDevices: []
        property var availableDevices: []

        Timer { interval: 10000; running: true; repeat: true; onTriggered: { btStatProc.start(); btPairedProc.start(); if (discovering) btAvailProc.start(); } }

        Process {
            id: btStatProc; command: ["bluetoothctl", "show"]; running: false
            stdout: SplitParser {
                onRead: data => {
                    var line = data.toString();
                    if (line.includes("Powered: yes")) btService.btPowered = true;
                    else if (line.includes("Powered: no")) btService.btPowered = false;
                    if (line.includes("Discovering: yes")) btService.discovering = true;
                    else if (line.includes("Discovering: no")) btService.discovering = false;
                }
            }
        }

        Process {
            id: btPairedProc; command: ["bluetoothctl", "devices", "Paired"]; running: false
            stdout: SplitParser {
                onRead: data => {
                    var line = data.toString().trim();
                    if (!line.startsWith("Device")) return;
                    var match = line.match(/Device ([A-F0-9:]+) (.+)/);
                    if (match) {
                        var mac = match[1], name = match[2];
                        if (!btService.pairedDevices.some(d => d.mac === mac))
                            btService.pairedDevices.push({ mac: mac, name: name, connected: false });
                    }
                }
            }
        }

        Process {
            id: btAvailProc; command: ["bluetoothctl", "devices"]; running: false
            stdout: SplitParser {
                onRead: data => {
                    var line = data.toString().trim();
                    if (!line.startsWith("Device")) return;
                    var match = line.match(/Device ([A-F0-9:]+) (.+)/);
                    if (match) {
                        var mac = match[1], name = match[2];
                        if (!btService.pairedDevices.some(d => d.mac === mac) && !btService.availableDevices.some(d => d.mac === mac))
                            btService.availableDevices.push({ mac: mac, name: name });
                    }
                }
            }
        }

        function togglePower() { if (btPowered) btPowerOff.start(); else btPowerOn.start(); }
        function startDiscovery() { availableDevices = []; btScanOn.start(); }
        function stopDiscovery() { btScanOff.start(); }
        function pair(mac) { btPairProc.command = ["bash", "-c", "echo 'pair " + mac + "' | bluetoothctl && echo 'connect " + mac + "' | bluetoothctl"]; btPairProc.start(); }
        function connect(mac) { btConnProc.command = ["bluetoothctl", "connect", mac]; btConnProc.start(); }
        function remove(mac) { btRemProc.command = ["bluetoothctl", "remove", mac]; btRemProc.start(); }

        Process { id: btPowerOn; command: ["bluetoothctl", "power", "on"]; running: false }
        Process { id: btPowerOff; command: ["bluetoothctl", "power", "off"]; running: false }
        Process { id: btScanOn; command: ["bluetoothctl", "scan", "on"]; running: false }
        Process { id: btScanOff; command: ["bluetoothctl", "scan", "off"]; running: false }
        Process { id: btPairProc; command: []; running: false }
        Process { id: btConnProc; command: []; running: false }
        Process { id: btRemProc; command: []; running: false }
    }

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 12
        anchors.rightMargin: 12
        spacing: 15

        // Left: Logo + Workspace dots
        RowLayout {
            spacing: 10

            Text {
                text: "NixOS Homelab"
                color: "#cdd6f4"
                font.bold: true
                font.pointSize: 11
            }

            Item { width: 4; height: 1 }

            Repeater {
                model: 7

                Rectangle {
                    id: wsDot
                    required property int index

                    property bool isFocused: Hyprland.focusedWorkspace !== null && Hyprland.focusedWorkspace.id === (index + 1)
                    property bool hasWindows: {
                        if (Hyprland.focusedWorkspace === null) return false;
                        for (let i = 0; i < Hyprland.workspaces.count; i++) {
                            let ws = Hyprland.workspaces.get(i);
                            if (ws && ws.id === (index + 1) && ws.toplevels.count > 0) return true;
                        }
                        return false;
                    }

                    width: isFocused ? 18 : 8
                    height: 8
                    radius: 4
                    color: isFocused ? "#89b4fa" : (hasWindows ? "#a6adc8" : "#45475a")

                    Behavior on width { NumberAnimation { duration: 200; easing.type: Easing.InOutQuad } }
                    Behavior on color { ColorAnimation { duration: 200 } }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: Hyprland.dispatch("workspace " + (wsDot.index + 1))
                    }
                }
            }
        }

        Item { Layout.fillWidth: true }

        // Right: System buttons
        RowLayout {
            spacing: 8

            BarButton {
                iconText: "󰕾"
                label: audioService.ready ? Math.round(audioService.volume * 100) + "%" : ""
                active: audioService.ready && !audioService.muted
                menuOpen: root.activeMenu === 4
                onClicked: root.toggleMenu(4)
            }

            BarButton {
                iconText: "󰤨"
                label: wifiService.currentSSID || "Wi-Fi"
                active: wifiService.wifiEnabled
                menuOpen: root.activeMenu === 1
                onClicked: root.toggleMenu(1)
            }

            BarButton {
                iconText: "󰂯"
                label: btService.btPowered ? "On" : "Off"
                active: btService.btPowered
                menuOpen: root.activeMenu === 2
                onClicked: root.toggleMenu(2)
            }

            BarButton {
                iconText: "⏻"
                label: ""
                active: false
                menuOpen: root.activeMenu === 3
                onClicked: root.toggleMenu(3)
            }
        }
    }

    // Popups
    WifiMenu { anchorWindow: root; visible: root.activeMenu === 1; onDismiss: root.activeMenu = 0 }
    BluetoothMenu { anchorWindow: root; visible: root.activeMenu === 2; onDismiss: root.activeMenu = 0 }
    PowerMenu { anchorWindow: root; visible: root.activeMenu === 3; onDismiss: root.activeMenu = 0 }
    AudioMenu { anchorWindow: root; visible: root.activeMenu === 4; onDismiss: root.activeMenu = 0 }
}
