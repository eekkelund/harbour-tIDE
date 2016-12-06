import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {

    id: root
    property string caption
    property alias src: icon.source

    width: Theme.itemSizeSmall
    height: Theme.itemSizeSmall
    clip: true

    Image {
        id: icon
        asynchronous: true
        width: Theme.iconSizeSmall * 1.2
        height: Theme.iconSizeSmall * 1.2
        anchors.centerIn: parent
    }

    Image {
        source: "graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
    }


}
