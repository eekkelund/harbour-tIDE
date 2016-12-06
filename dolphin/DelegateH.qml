import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0


BackgroundItem {
    id: root
    property alias candidate: candidate

    Label {
        id: candidate
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: ( parent.down || index === 0 )? Theme.highlightColor : Theme.primaryColor
        font { pixelSize: ( settings.size === 0? Theme.fontSizeMedium: ( settings.size === 1? Theme.fontSizeLarge: Theme.fontSizeLarge ) ) }
        text: result[index]
        textFormat: Text.PlainText
    }

    onClicked: {
        buttonPressEffect.play()
        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
        acceptWord(result[index])
    }

    /*onPressAndHold: {
        checkDictionary(result[index])
    }*/

    Image {
        source: "graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
    }
}


