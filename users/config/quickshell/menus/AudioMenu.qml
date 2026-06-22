import Quickshell
import QtQuick
import QtQuick.Layouts
import QtQuick.Controls

Item {
    id: audioMenu

    property var anchorWindow: null
    signal dismiss()

    visible: false
    width: 320
    height: 120
    x: anchorWindow ? anchorWindow.width - width - 20 : 0
    y: anchorWindow ? anchorWindow.height + 5 : 0

    Rectangle {
        anchors.fill: parent
        color: "#313244"
        radius: 10
        border.color: "#45475a"
        border.width: 1

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 14
            spacing: 12

            Text {
                text: "Audio"
                color: "#cdd6f4"
                font.bold: true
                font.pointSize: 12
            }

            RowLayout {
                spacing: 10

                Text {
                    text: audioService.muted ? "󰝟" : "󰕾"
                    color: "#89b4fa"
                    font.pointSize: 16
                }

                Slider {
                    id: volumeSlider
                    Layout.fillWidth: true
                    from: 0.0
                    to: 1.0
                    value: audioService.volume
                    onMoved: audioService.setVolume(value)

                    background: Rectangle {
                        x: volumeSlider.leftPadding
                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                        width: volumeSlider.availableWidth
                        height: 4
                        radius: 2
                        color: "#45475a"

                        Rectangle {
                            width: volumeSlider.visualPosition * parent.width
                            height: parent.height
                            radius: 2
                            color: "#89b4fa"
                        }
                    }

                    handle: Rectangle {
                        x: volumeSlider.leftPadding + volumeSlider.visualPosition * (volumeSlider.availableWidth - width)
                        y: volumeSlider.topPadding + volumeSlider.availableHeight / 2 - height / 2
                        width: 16
                        height: 16
                        radius: 8
                        color: "#cdd6f4"
                        border.color: "#89b4fa"
                        border.width: 2
                    }
                }

                Text {
                    text: Math.round(audioService.volume * 100) + "%"
                    color: "#a6adc8"
                    font.pointSize: 10
                    Layout.minimumWidth: 35
                    horizontalAlignment: Text.AlignRight
                }
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: "#45475a" }

            Rectangle {
                Layout.fillWidth: true
                height: 32
                radius: 6
                color: muteMa.containsMouse ? "#45475a" : "transparent"

                Text {
                    anchors.centerIn: parent
                    text: audioService.muted ? "Unmute" : "Mute"
                    color: "#cdd6f4"
                    font.pointSize: 10
                }

                MouseArea {
                    id: muteMa
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: audioService.toggleMute()
                    cursorShape: Qt.PointingHandCursor
                }
            }
        }
    }
}
