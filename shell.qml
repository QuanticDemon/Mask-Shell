import QtQuick
import Quickshell
import "components"

ShellRoot{
    PanelWindow{
        implicitHeight:50
        anchors{
            left:true
            right:true 
            bottom:true 
        }
        
        color:"transparent"
        Bar{}
    }
}