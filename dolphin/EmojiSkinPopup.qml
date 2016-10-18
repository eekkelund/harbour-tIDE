import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import "Emoji.js" as Emoji

Rectangle {

    property string textData
    property var race: ["", "\uD83C\uDFFB", "\uD83C\uDFFC", "\uD83C\uDFFD", "\uD83C\uDFFE", "\uD83C\uDFFF"]

    property int activeCell: 0
    property alias opening: openAnimation.running
    property real bottomLine
    property int targetHeight

    id: root
    z: 32
    anchors.verticalCenter: parent.verticalCenter
    radius: geometry.popperRadius
    color: Theme.highlightColor

    visible: false
    clip: openAnimation.running
    anchors.left: parent.left
    anchors.right: parent.right
    anchors.leftMargin: Theme.paddingLarge
    anchors.rightMargin: Theme.paddingLarge
    height: Theme.itemSizeSmall
    targetHeight: 0

    Row {
        anchors.fill: parent

        Repeater {
            model: race
            delegate: Component {

                EmojiKey {
                    width: parent.width / 7
                    height: parent.height
                    caption: textData + modelData
                    src: Emoji.emojifyNew(textData + modelData)

                    onClicked: {
                        if ( frequent.indexOf(caption) === -1 ) frequent.unshift(caption)
                        commit(caption)
                        hide()
                    }

                }
            }
        }

        EmojiKey {
            width: parent.width / 7
            height: parent.height
            src: "image://theme/icon-l-cancel"
            onClicked: hide()
        }

    }

    NumberAnimation on height {
        id: openAnimation
        duration: 128
        easing.type: Easing.OutQuad
        to: root.targetHeight
    }

    SequentialAnimation {
        id: fadeAnimation
        NumberAnimation {
            duration: 128
            to: 0
            target: root
            property: "opacity"
        }

        ScriptAction {
            script: {
                visible = false
            }
        }
    }

    function show(top, left) {
        fadeAnimation.stop()
        root.targetHeight = Theme.itemSizeSmall
        opacity = 1
        visible = true
        openAnimation.start()
    }

    function hide() {
        if (opening) {
            openAnimation.stop()
            visible = false
        } else if (visible) {
            fadeAnimation.start()
        }
        root.targetHeight = 0
    }

}
