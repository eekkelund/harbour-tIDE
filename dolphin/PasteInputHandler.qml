// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0

InputHandler {
    topItem: Component {
        TopItem {
            SilicaFlickable {
                anchors.fill: parent
                flickableDirection: Flickable.HorizontalFlick
                boundsBehavior: !keyboard.expandedPaste && Clipboard.hasText ? Flickable.DragOverBounds : Flickable.StopAtBounds

                onDraggingChanged: {
                    if (!dragging && !keyboard.expandedPaste && contentX < -Theme.paddingLarge) {
                        keyboard.expandedPaste = true
                        contentX = 0
                    }
                }
                PasteButton {
                    onClicked: {
                        MInputMethodQuick.sendCommit(Clipboard.text)
                        keyboard.expandedPaste = false
                    }
                }
            }
        }
    }

    verticalItem: Component {
        Item {
            PasteButtonVertical {
                visible: Clipboard.hasText
                width: parent.width
                height: visible ? geometry.keyHeightLandscape : 0
                popupAnchor: 2 // center

                onClicked: MInputMethodQuick.sendCommit(Clipboard.text)
            }
        }
    }

    function handleKeyClick() {
        keyboard.expandedPaste = false
        return false
    }
}
