import QtQuick 2.2
import Sailfish.Silica 1.0

Rectangle {
    id: root
    z: 8192
    property string label
    width: label.width + geometry.clearPasteMargin
    height: label.height + geometry.clearPasteMargin
    radius: geometry.popperRadius
    color: Qt.darker(Theme.highlightBackgroundColor, 1.2)
    anchors.bottom: parent.top
    x: 0
    visible: false

    onLabelChanged: {
        visible = true
        timer.start()
    }

    Timer {
        id: timer
        interval: 4096
        onTriggered: {
            parent.visible = false
        }
    }

    Label {
        id: label
        anchors.centerIn: parent
        color: Theme.primaryColor
        text: parent.label
    }
}
