import QtQuick 2.2
import QtQuick 2.2
import Sailfish.Silica 1.0
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0

Row {
    id: root
    height: parent.height

    Row {
        visible: keyboard.inSymView && keyboard.layout.inEmojiView
        height: parent.height

        EmojiTab {
            src: "face-2.gif"
            onClicked: symbolKeyboard.model = symbolKeyboard.face
        }

        EmojiTab {
            src: "object-43.gif"
            onClicked: symbolKeyboard.model = symbolKeyboard.object

        }


        EmojiTab {
            src: "nature-65.gif"
            onClicked: symbolKeyboard.model = symbolKeyboard.nature

        }

        EmojiTab {
            src: "place-1.gif"
            onClicked: symbolKeyboard.model = symbolKeyboard.place

        }

        EmojiTab {
            src: "sign-13.gif"
            onClicked: symbolKeyboard.model = symbolKeyboard.sign
        }

        BackspaceKey {
            width: 97
            height: Theme.itemSizeSmall
            MouseArea {
                anchors.fill: parent
                onClicked: MInputMethodQuick.sendKey(Qt.Key_Backspace)
            }
        }
    }
}
