import QtQuick
import "../services"
Item{
    id:root
    width:1.4
    height:parent.height
    property color colorSeparator:Theme.bg_l1
    
    Rectangle{
        anchors.fill:parent 
        color:root.colorSeparator
        radius:height/2
        anchors.topMargin:8
        anchors.bottomMargin:3
    }
}