import QtQuick 2.2
import Sailfish.Silica 1.0
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0

Rectangle {
    id: container
    anchors.fill: parent
    color: Theme.highlightDimmerColor


    //Block unwanted close keyboard gesture
    MultiPointTouchArea {
        anchors.fill: parent
        z: -1
    }

    More {
        id: more
        anchors.bottom: parent.bottom
    }

    Help {
        id: help
    }

    SilicaListView {
        id: listView
        anchors.fill: parent
        contentHeight: Math.max(parent.height, header.height)
        interactive: true
        flickableDirection: Flickable.VerticalFlick
        model: result
        boundsBehavior: ( !keyboard.expandedPaste && Clipboard.hasText ) || ( more.visible ) ? Flickable.DragOverBounds : Flickable.StopAtBounds
        clip: true

        header: Component {
            Toolbar {
                id: toolbar
                width: parent.width
                count: result.length
                //columns: 3
            }
        }

        delegate: DelegateH {
            id: delegateH
            width: container.width
            height: geometry.keyHeightLandscape * settings.scale
        }


        onDragEnded: {
            if ( atYEnd && result.length > 8 ) {
                SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
                buttonPressEffect.play()

                if ( preedit !== "" && result.length <= 16 ) {
                    applyMoreWord()
                }

                fetchMany = true
            }
        }

        onContentHeightChanged: {
            timer.restart()
        }

        Connections {
            target: Clipboard
            onTextChanged: {
                if (Clipboard.hasText) {
                    //Need to have updated width before repositioning view
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

