import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import "../panels"
import "../services"
Item{

    
    MaskPanel{
            id:maskPanel
    }

    
    

    Rectangle{
        anchors.fill:parent 
        color:mouseMask.containsMouse ? "gray":"transparent"
        MouseArea{
            id:mouseMask
            hoverEnabled:true 
            cursorShape:Qt.PointingHandCursor
            anchors.fill:parent

            onClicked:{
                console.log("panel")
                maskPanel.opened = !maskPanel.opened
            }
        }

        Behavior on color{
            ColorAnimation{
                duration:150
                easing.type:Easing.OutCubic
            }
        }
        Rectangle{
            anchors.centerIn:parent 
            width:30 
            height:30
            border.color:Theme.primary
            border.width:3
            radius:height/2 
            color:"transparent"

            
        }
    }
    
}