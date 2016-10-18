import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

Rectangle {
    id: root

    height: parent.height
    width: label.width + Theme.paddingSmall * 2
    color: Theme.highlightBackgroundColor

    Label {
        id: label
        text: preedit
        color: Theme.primaryColor
        anchors.centerIn: parent
    }





}
