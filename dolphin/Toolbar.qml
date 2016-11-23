import QtQuick 2.2
import Sailfish.Silica 1.0
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0

Flow {
    id: root
    property int count

    //Paste
    PasteButton {
        visible: keyboard.portraitMode && Clipboard.hasText && !fetchMany
        height: Theme.itemSizeSmall
        onClicked: commit(Clipboard.text)
    }

    PasteButtonVertical {
        visible: !keyboard.portraitMode && Clipboard.hasText && !fetchMany
        height: visible ? Theme.itemSizeSmall : 0
        width: visible ? parent.width : 0
        popupParent: container
        popupAnchor: 2 // center

        onClicked: commit(Clipboard.text)
    }

    Component.onCompleted: {


        var toolbar
toolbar = cursorBar.createObject(root, {  })
        //Toolbar
        switch(settings.toolbar) {
        case 1:
            toolbar = cursorBar.createObject(root, {  })
            break
        case 2:
            toolbar = numberBar.createObject(root, {  })
            break
        case 3:
            toolbar = functionBar.createObject(root, {  })
        }
    }

    //Cursor
    Component {
        id: cursorBar

        Repeater {
            model: ["left", "right", "up", "down"]

            delegate: Component {
                CursorKey {
                    width: height
                    height: Theme.itemSizeSmall
                    visible: root.count === 0 ? true : false
                    direction: modelData
                }
            }
        }

    }

    //Number
    Component {
        id: numberBar

        Repeater {
            model: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"]

            delegate: Component {
                CommitKey {
                    width: height / 2
                    height: Theme.itemSizeSmall
                    visible: root.count === 0 ? true : false
                    caption: modelData
                    onClicked: MInputMethodQuick.sendCommit(caption)
                }
            }
        }
    }

    //Function

    Component {
        id: functionBar

        Repeater {

            CommitKey {
                width: height
                height: Theme.itemSizeSmall
                visible: root.count === 0 ? true : false
                caption: "HM"
                onClicked: MInputMethodQuick.sendKey(Qt.Key_Home, 0,  "", Maliit.KeyClick)
            }

            CommitKey {
                width: height
                height: Theme.itemSizeSmall
                visible: root.count === 0 ? true : false
                caption: "ED"
                onClicked: MInputMethodQuick.sendKey(Qt.Key_End, 0,  "", Maliit.KeyClick)
            }

            CommitKey {
                width: height
                height: Theme.itemSizeSmall
                visible: root.count === 0 ? true : false
                caption: "AL"
                onClicked: MInputMethodQuick.sendKey(Qt.Key_A, Qt.ControlModifier, 0,  "", Maliit.KeyClick)
            }

            CommitKey {
                width: height
                height: Theme.itemSizeSmall
                visible: root.count === 0 ? true : false
                caption: "CP"
                onClicked: MInputMethodQuick.sendKey(Qt.Key_C, Qt.ControlModifier, 0,  "", Maliit.KeyClick)
            }

            CommitKey {
                width: height
                height: Theme.itemSizeSmall
                visible: root.count === 0 ? true : false
                caption: "PS"
                onClicked:  MInputMethodQuick.sendKey(Qt.Key_V, Qt.ControlModifier, 0,  "", Maliit.KeyClick)
            }
        }
    }
}
