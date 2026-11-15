import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Pam
import "../services"

Scope {
    id: root
    property string password: ""
    property bool busy: false
    property bool failed: false

    PamContext {
        id: pam
        config: "password.conf"
        configDirectory: "pam"       

        
        onPamMessage: {
            if (responseRequired)
                respond(root.password)
        }

        
        onCompleted: result => {
            root.busy = false
            root.password = ""
            if (result === PamResult.Success) {
                root.failed = false
                Locker.locked = false
            } else {
                root.failed = true
            }
        }
    }

    WlSessionLock {
        id: sessionLock
        locked: Locker.locked

        WlSessionLockSurface {
            color: "black"

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 12

                TextField {
                    id: field
                    Layout.preferredWidth: 260
                    echoMode: TextInput.Password          
                    placeholderText: "Contraseña"
                    enabled: !root.busy
                    color: "white"

                    Component.onCompleted: forceActiveFocus()
                    onEnabledChanged: if (enabled) forceActiveFocus()

                    onAccepted: {                          // al dar Enter
                        if (text.length === 0 || pam.active) return
                        root.password = text
                        text = ""
                        root.busy = true
                        pam.start()                        // dispara el paso 1
                    }
                }

                Text {
                    text: "Contraseña incorrecta"
                    color: "#ff6b6b"
                    visible: root.failed
                    Layout.alignment: Qt.AlignHCenter
                }
            }
        }
    }
}