import QtQuick
import Quickshell
import "../widgets"
import "../services"
Item{
    id:root
    anchors.fill:parent 
    Rectangle{ 
        anchors.fill:parent 
        color:"black"

        Row{
            anchors.fill:parent 
            spacing:5 
            Mask{
                width:50 
                height:50
            }
            Separator{
                
            }
        }
    }
}