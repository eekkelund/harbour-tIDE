import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import com.meego.maliitquick 1.0

BackgroundItem {
    property string direction

    width: height
    height: Theme.itemSizeSmall

    Image {
        id: image
        anchors.centerIn: parent
        height: parent.height / 2
        fillMode: Image.PreserveAspectFit
        source: "image://theme/icon-m-" + direction + (pressed ? ("?" + Theme.highlightColor) : "")
    }

    onPressedChanged: {
        if ( pressed ) {
            switch(direction) {
            case"left":
                MInputMethodQuick.sendKey(Qt.Key_Left, 0, "", Maliit.KeyClick)
                break
            case "right":
                MInputMethodQuick.sendKey(Qt.Key_Right, 0, "", Maliit.KeyClick)
                break
            case "up":
                MInputMethodQuick.sendKey(Qt.Key_Up, 0, "", Maliit.KeyClick)
                break
            case "down":
                MInputMethodQuick.sendKey(Qt.Key_Down, 0, "", Maliit.KeyClick)
                break
            }
        }
    }
}
