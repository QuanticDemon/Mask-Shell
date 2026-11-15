import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "../services"

PanelWindow {
    id: root

    implicitWidth: 400
    implicitHeight: 180

    visible: opened
    color: "transparent"

    property string op: ""
    property bool opened: false

    Rectangle {
        anchors.fill: parent
        color: Theme.bg
        radius: 12

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 12

            Text {
                text: "Are you sure you want to " + root.op + "?"
                color: "white"
                font.family: Theme.font
                font.bold: true
                font.pixelSize: 16
                Layout.alignment:Qt.AlignHCenter
                

                
                wrapMode: Text.WordWrap
            }

            Item {
                Layout.fillHeight: true
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 10

                Button {
                    text: "Cancel"

                    Layout.preferredWidth:180
                    Layout.preferredHeight: 36
                    Layout.fillHeight: false

                    background: Rectangle {
                        radius: 8
                        color: parent.hovered ? "#353535" : "#252525"
                        border.color: "#454545"
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "#D0D0D0"
                        font.pixelSize: 13
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked: root.opened = false
                }

                Button {
                    text:root.op

                    Layout.preferredWidth:180
                    Layout.preferredHeight: 36
                    Layout.fillHeight: false

                    background: Rectangle {
                        radius: 8
                        color: parent.hovered ? Theme.hoverPrimary : Theme.primary
                    }

                    contentItem: Text {
                        text: parent.text
                        color: "#FFFFFF"
                        font.pixelSize: 13
                        font.bold: true
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }

                    onClicked:{
                        if(root.op === "Shutdown"){
                            Quickshell.execDetached(["systemctl", "poweroff"])
                            root.opened = false
                        }
                        else{
                            Quickshell.execDetached(["systemctl", "reboot"])
                            root.opened = false
                        }
                    }
                }
            }
        }
    }
}