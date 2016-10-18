import QtQuick 2.2
import Sailfish.Silica 1.0
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0

TopItem {
    id: container

    Rectangle {
        anchors.fill: parent
        color: Theme.highlightDimmerColor
        opacity: 0.2

        Separator {
            color: Theme.highlightColor
            width: parent.width
            anchors.bottom: parent.bottom
        }
    }

    More {
        id: more
    }

    Help {
        id: help
    }

    SilicaListView {
        id: listView
        height: parent.height
        width: parent.width
        interactive: true
        flickableDirection: Flickable.HorizontalFlick
        orientation: ListView.Horizontal
        model: result
        boundsBehavior: ( !keyboard.expandedPaste && Clipboard.hasText ) || ( more.visible ) ? Flickable.DragOverBounds : Flickable.StopAtBounds

        header: Component {
            Toolbar {
                id: toolbar
                height: Theme.itemSizeSmall
                count: result.length
            }
        }

        delegate: Component {
            DelegateH {
                id: delegateH
                width: candidate.width + Theme.paddingMedium * 2
                height: container.height
            }
        }

        onDragEnded: {
            if ( atXEnd && result.length > 8 ) {
                SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
                buttonPressEffect.play()

                if ( preedit !== "" && result.length <= 16 ) {
                    applyMoreWord()
                }

                fetchMany = true
            }
        }

        onContentWidthChanged: {
            timer.restart()
        }

        Connections {
            target: Clipboard
            onTextChanged: {
                if (Clipboard.hasText) {
                    timer.restart()
                }
            }
        }

        Timer {
            id: timer
            interval: 16
            onTriggered: listView.positionViewAtBeginning()
        }


    }
}


