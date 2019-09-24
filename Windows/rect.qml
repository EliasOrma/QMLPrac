import QtQuick 2.0

Rectangle {
    // This property has to be inited when constructed
    property int num_name: 0
    // This property has to be inited when constructed
    property string clr: "BLUE"
    color: clr
    width: 140
    height: 80
    border.color: "grey"
    radius: 5
    MouseArea {
        anchors.fill: parent
        onClicked: {
            // Work as a direct pointer because of the way
            // that the object is initialized at main.cpp
            wcontrol.activeboxchange(num_name - 1)
        }
    }
}
