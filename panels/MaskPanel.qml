import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Effects
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland
import Quickshell.Wayland
import Qt5Compat.GraphicalEffects
import "../services"
import "../widgets"


PanelWindow{
    id:root 
    color:"transparent"

    Power{
        id:power
    }
     
    property bool opened:false
    property var filteredApps:{
        const apps = DesktopEntries.applications.values 
        const query = searchBar.text.trim().toLowerCase()
        if (query.length === 0) return apps
        return apps.filter(app=>app.name.toLowerCase().includes(query))
        
    }
    Lock{
        
    }
    function powerTools(name){
        switch(name){
            case "off":
                power.opened = !power.opened 
                power.op = "Shutdown"
                
                
                break 
            case "suspend":
                Quickshell.execDetached(["systemctl","suspend"])
                break
            case "reboot":
                power.opened = !power.opened 
                power.op = "Reboot"
            
            
                break
            case "lock":
                console.log("bloqueando")
                Locker.locked = true 
                break
            default:
                console.log("Nada que hacer")
                break
        }
        root.opened = false
    }
    visible:opened 
    exclusiveZone:0 
    implicitWidth:600 
    implicitHeight:500
    anchors{
        bottom:true 
        left:true 
    }

    margins{
        bottom:4 
        left:4
    }
    onOpenedChanged:{
        if(opened){
            Qt.callLater(()=>{
                searchBar.forceActiveFocus()
            })
        }else{
            searchBar.text = ""
        }
        
    }

    WlrLayershell.keyboardFocus: opened ? WlrKeyboardFocus.OnDemand:WlrKeyboardFocus.None

    HyprlandFocusGrab{
        windows:[root]
        active:root.opened
        onCleared:root.opened = false 
        
    }


    Rectangle{
        width:parent.width
        height:parent.height
        y:root.opened ? 0:root.height
        color:"black"
        radius:10

        Behavior on y{
            NumberAnimation{
                duration:150
                easing.type:Easing.OutCubic
            }
        }

        RowLayout{
            anchors.fill:parent 
            spacing:10
            anchors.margins:10
            
            Rectangle{
                color:Theme.bg_l1
                Layout.preferredWidth:230
                Layout.fillHeight:true 
                radius:12 

                ColumnLayout{
                    anchors.fill:parent 
                    spacing:5 
                    anchors.margins:10
                    
                    Rectangle{
                            id:avatar
                            Layout.preferredHeight:100
                            Layout.preferredWidth:100
                            Layout.alignment: Qt.AlignHCenter
                            radius:height/2
                            clip:true 
                            color:"transparent"

                            Image{
                                id:imgAvatar 
                                source:"file://"+Quickshell.env("HOME")+"/.face"
                                anchors.fill:parent 
                                fillMode:Image.PreserveAspectCrop
                                asynchronous:true 
                                cache:true 
                                visible:false
                            }

                            OpacityMask{
                                anchors.fill:parent 
                                source:imgAvatar
                                maskSource: Rectangle{
                                    width:avatar.width
                                    height:avatar.height
                                    radius:height/2
                                }
                            }
                            
                    }
                    Text{
                        color:"white"
                        text:"Khaos"
                        font.family:Theme.font
                        font.pixelSize:20
                        Layout.alignment: Qt.AlignHCenter
                    }
                    
                    Item{
                        Layout.fillHeight:true
                    }

                    Row{
                        
                        Layout.preferredHeight:50
                        Layout.alignment:Qt.AlignHCenter
                        spacing:10 
                        Rectangle{
                            width:40
                            height:40
                            radius:height/2 
                            color:mouseOff.containsMouse ? Theme.hover2:Theme.bg
                            anchors.verticalCenter:parent.verticalCenter
                            Text{
                                text:""
                                anchors.centerIn:parent
                                leftPadding:2
                                color:"white"
                                font.family:Theme.font
                            }
                            MouseArea{
                                id:mouseOff
                                hoverEnabled:true 
                                cursorShape:Qt.PointingHandCursor
                                anchors.fill:parent 
                                onClicked:{
                                    root.powerTools("off")
                                }
                            }
                        
                        }
                        Rectangle{
                            width:40
                            height:40
                            radius:height/2 
                            color:mouseSuspend.containsMouse ? Theme.hover2:Theme.bg
                            anchors.verticalCenter:parent.verticalCenter
                            Text{
                                text:"󰤄"
                                anchors.centerIn:parent
                                leftPadding:2
                                color:"white"
                                font.family:Theme.font
                            }
                            MouseArea{
                                id:mouseSuspend
                                hoverEnabled:true 
                                cursorShape:Qt.PointingHandCursor
                                anchors.fill:parent 
                                onClicked:{
                                    root.powerTools("suspend")
                                }
                            }
                        
                        }
                        Rectangle{
                            width:40
                            height:40
                            radius:height/2 
                            color:mouseReboot.containsMouse ? Theme.hover2:Theme.bg
                            anchors.verticalCenter:parent.verticalCenter
                            Text{
                                text:"󰜉"
                                font.pixelSize:17
                                anchors.centerIn:parent
                                leftPadding:2
                                color:"white"
                                font.family:Theme.font
                            }
                            MouseArea{
                                id:mouseReboot
                                hoverEnabled:true 
                                cursorShape:Qt.PointingHandCursor
                                anchors.fill:parent 
                                onClicked:{
                                    root.powerTools("reboot")
                                }
                            }
                        
                        }
                        Rectangle{
                            width:40
                            height:40
                            radius:height/2 
                            color:mouseLock.containsMouse ? Theme.hover2:Theme.bg
                            anchors.verticalCenter:parent.verticalCenter
                            Text{
                                text:""
                                anchors.centerIn:parent
                                leftPadding:2
                                color:"white"
                                font.family:Theme.font
                            }
                            MouseArea{
                                id:mouseLock
                                hoverEnabled:true 
                                cursorShape:Qt.PointingHandCursor
                                anchors.fill:parent 
                                onClicked:{
                                    root.powerTools("lock")
                                }
                            }
                        
                        }
                        
                    }
                }
            }

            Separator{
                colorSeparator:Theme.primary
            }

            Rectangle{
                Layout.fillWidth:true 
                Layout.fillHeight:true
                radius:12
                color:Qt.darker(Theme.bg_l1)

                ColumnLayout{
                    anchors.fill:parent 
                    spacing:10 
                    anchors.margins:10

                    Rectangle{
                        Layout.fillWidth:true 
                        Layout.preferredHeight:40
                        radius:18
                        color:Qt.darker(Theme.bg_l1)
                        border.width:0.9
                        border.color:Theme.bg_l1

                        RowLayout{
                            anchors.fill:parent 
                            anchors.leftMargin:10
                            anchors.rightMargin:10
                            spacing:5

                            Text{
                                
                                Layout.fillHeight:true
                                verticalAlignment:Text.AlignVCenter
                                text:""
                                font.bold:true 
                                font.pixelSize:15
                                font.family:Theme.font
                                color:Theme.bg_l1
                            }
                            TextField{
                                id:searchBar
                                Layout.fillHeight:true
                                Layout.fillWidth:true
                                verticalAlignment:Text.AlignVCenter
                                placeholderText:"Search application"
                                placeholderTextColor:Theme.bg_l1
                                font.bold:true 
                                focus:true
                                font.pixelSize:15
                                font.family:Theme.font
                                color:"white"
                                background:Rectangle{
                                    color:"transparent"
                                }
                            }

                            
                        }
                    }

                    ListView{
                        id:list
                        Layout.fillWidth:true 
                        Layout.fillHeight:true
                        clip:true 
                        model:root.filteredApps
                        spacing:2
                        delegate:Rectangle{
                            width:ListView.view.width
                            height:60 
                            color: mouseApp.containsMouse
                                   ? Theme.hover1
                                   : Theme.bg
                            radius:8 

                            Behavior on color{
                                ColorAnimation{
                                    duration:100 
                                    easing.type:Easing.OutCubic
                                }
                            }

                            RowLayout{
                                anchors.fill:parent 
                                spacing:10
                                anchors.leftMargin:10
                                Image{
                                    Layout.preferredHeight:30
                                    Layout.preferredWidth:30
                                    Layout.alignment:Qt.AlignVCenter
                                    
                                    source: Quickshell.iconPath(modelData.icon)
                                    asynchronous:true 
                                    cache:true 
                                }

                                ColumnLayout{
                                    Layout.fillHeight:true 
                                    Layout.fillWidth:true 
                                    Layout.alignment:Qt.AlignVCenter
                                    
                                    Text{
                                        text:modelData.name
                                        color:"white"
                                        font.family:Theme.font
                                        font.bold:true
                                        Layout.fillWidth:true 
                                        verticalAlignment:Text.AlignLeft
                                        
                                    }
                                    Text{
                                        text:modelData.comment
                                        color:"gray"
                                        font.family:Theme.font
                                        font.pixelSize:10
                                        Layout.fillWidth:true 
                                        verticalAlignment:Text.AlignLeft
                                        
                                    }
                                }
                            }
                            MouseArea{
                                id:mouseApp
                                hoverEnabled:true 
                                cursorShape:Qt.PointingHandCursor
                                anchors.fill:parent 

                                onClicked:{
                                    modelData.execute()
                                    
                                    root.opened = false
                                }
                            }
                            
                        }
                        
                    }
                }
            }
            

            
        }
    }
    
}