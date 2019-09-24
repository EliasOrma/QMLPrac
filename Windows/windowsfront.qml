import QtQuick 2.0
import QtQuick.Controls 1.4
import QtQuick.Controls 1.3
import QtQuick.Window 2.2

Window {
    visible: true
    width: 500
    height: 500
    id: root

    maximumWidth: 500
    minimumWidth: 500
    maximumHeight: 500
    minimumHeight: 500

    property int scrollheight: 0

    // For overall data needs
    property string amnttext: wcontrol.boxesamount
    property string currentcolorstr: "Current color is " + wcontrol.getColor
    property string currentcolor: wcontrol.getColor

    // For hiding unnecessary values when there is no boxes
    property bool visibleContent: false

    // Containor for rectObjects that are created dynamically
    property var rect_objects: []


    // Function for updating the first tabs rectangle colors
    function updateview()
    {
        // Iterates trough every rectangle and gets right color from them from backend
        for(var i = 1; i < rect_objects.length+1; i++)
        {
            rect_objects[i-1].clr = wcontrol.getIndexColor(i)
        }
        // hides unnecessary values when there is no boxes
        if(rect_objects.length == 0)
        {
            visibleContent = false
        }
        // unhides unnecessary values when there is no boxes
        else
        {
            visibleContent = true
        }
        scrollheight = Math.round((1 + rect_objects.length/3))*100

    }

    TabView
    {
        frameVisible: false
        Tab
        {
            //onActiveChanged: root.updateview()
            title: "Home"
            Column
            {

                Row {
                    id: buttons1
                    Rectangle
                    {
                        color: "white"
                        width: root.width
                        height: 100
                        border.color: "grey"
                        Button
                        {
                            text: "delete"
                            height: 50
                            width: 200
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: root.width/4
                            onClicked:
                            {
                                // Deletes Boxes info from backend
                                wcontrol.deletebox()
                                // Deletes rectObject from list
                                rect_objects.pop(wcontrol.getselectedindex())
                                // Deletes children from area
                                area.children[wcontrol.getselectedindex()].destroy()
                                // Updates first tabs view
                                root.updateview()
                            }
                        }
                        Button
                        {
                            text: "add"
                            height: 50
                            width: 200
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: -root.width/4
                            onClicked:
                            {
                                // Deletes Boxes info from backend
                                wcontrol.addbox()
                                // Creates new child to "area"-id and adds rectObject to list
                                area.createnew()
                                // Updates first tabs view
                                root.updateview()
                            }
                        }
                    }
                }
                Row
                {
                    ScrollView
                    {
                        horizontalScrollBarPolicy: Qt.ScrollBarAlwaysOff
                        width: root.width
                        height: 300
                        Rectangle
                        {
                            color: "white"
                            width: parent.width
                            height: scrollheight
                            Grid
                            {
                                id: area
                                columns: 3
                                spacing: 20
                                anchors.left: parent.left
                                anchors.top: parent.top
                                anchors.margins: 10
                                width: parent.width

                                function createnew()
                                {
                                    // Creates component with rect.qml file
                                    var component = Qt.createComponent("rect.qml")
                                    // Creates Object with area as parent
                                    var rect = component.createObject(area)
                                    // Sets propertyvariables for created object
                                    rect.num_name = area.children.length
                                    rect.clr = wcontrol.getIndexColor(rect.num_name)
                                    // Adds created objects to rect_objects list
                                    rect_objects.push(rect)
                                }
                            }
                        }
                    }
                }
                Row
                {
                    Rectangle
                    {
                        color: "white"
                        width: root.width
                        height: 100
                        border.color: "grey"
                        Text
                        {
                            text: amnttext
                            font.pointSize: 15
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -parent.height/6
                        }
                    }
                }
            }

        }
        // Second tab has the colorchanging functionality
        Tab
        {
            title: "Screen1"
            Column
            {
                Row
                {
                    Rectangle
                    {
                        color: "white"
                        width: root.width
                        height: 100
                        border.color: "grey"
                        Button
                        {
                            text: "red"
                            height: 50
                            width: 200
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: root.width/4
                            onClicked:
                            {
                                wcontrol.getColor = "RED"
                                root.updateview()
                            }
                        }
                        Button
                        {
                            text: "blue"
                            height: 50
                            width: 200
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: -root.width/4
                            onClicked:
                            {
                                wcontrol.getColor = "BLUE"
                                root.updateview()
                            }
                        }
                    }
                }
                Row
                {
                    Rectangle
                    {
                        color: "white"
                        width: root.width
                        height: 300

                        Rectangle
                        {
                            visible: visibleContent
                            color: currentcolor
                            width: 280
                            height: 160
                            anchors.centerIn: parent
                            border.color: "grey"
                            radius: 5
                        }

                    }
                }
                Row
                {
                    Rectangle
                    {
                        color: "white"
                        width: root.width
                        height: 100
                        Text
                        {
                            visible: visibleContent
                            text: currentcolorstr
                            font.pointSize: 15
                            anchors.centerIn: parent
                            anchors.verticalCenterOffset: -parent.height/6
                        }
                    }
                }
            }
        }
        // Last tab has Basic row layout.
        Tab
        {
            title: "Screen2"
            Column
            {
                anchors.fill: parent
                Row
                {
                    Rectangle
                    {
                        color: "white"
                        width: root.width
                        height: root.height/6
                        Text
                        {
                            text: "User Prefrences"
                            anchors.centerIn: parent
                        }
                    }
                }
                Row
                {
                    Rectangle
                    {
                        color: "white"
                        width: root.width
                        height: root.height/6
                        Text
                        {
                            text: wcontrol.boxesamount
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: -parent.width/3
                        }
                    }
                }
                Row
                {
                    Rectangle
                    {
                        color: "white"
                        width: root.width
                        height: root.height/6
                        Text
                        {
                            visible: visibleContent
                            text: currentcolorstr
                            anchors.centerIn: parent
                            anchors.horizontalCenterOffset: -parent.width/3
                        }
                    }
                }
            }
        }
    }
}
