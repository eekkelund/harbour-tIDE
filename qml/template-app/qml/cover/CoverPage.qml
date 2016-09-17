import QtQuick 2.0
import Sailfish.Silica 1.0

CoverBackground {
    Label {
        anchors.centerIn: parent
        text: qsTr("Application Cover")
    }
    CoverActionList {
        id: coverActions
        CoverAction {
            iconSource: "image://theme/icon-cover-favorite"
            onTriggered: {
                console.log("Cover action triggered")
            }
        }
    }
}


