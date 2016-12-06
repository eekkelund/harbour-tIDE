import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {
    id: close
    width: Theme.itemSizeSmall
    height: parent.height
    anchors.right: parent.right

    Image {
        width: 32
        height: 32
        opacity: 0.6
        anchors.centerIn: parent
        source: "image://theme/icon-close-vkb"
    }

    onPressed: {
        buttonPressEffect.play()
        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
    }

}
