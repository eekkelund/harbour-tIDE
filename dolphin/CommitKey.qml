import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {

    id: root
    property string caption
    property alias src: icon.source

    width: label.visible? label.width + Theme.paddingLarge * 2: icon.width + Theme.paddingMedium * 2
    height: Theme.itemSizeSmall

    Label {
        id: label
        visible: !icon.visible
        anchors.centerIn: parent
        text: caption
        font.pixelSize: Theme.fontSizeSmall
    }

    Image {
        id: icon
        visible: icon.status === Image.Error || icon.status === Image.Null || src === null || typeof src === "undefined"  ? false : true
        source: ""
        asynchronous: true
        width: Theme.iconSizeSmall
        height: Theme.iconSizeSmall
        anchors.centerIn: parent
    }

    Image {
        source: "graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
    }

}
