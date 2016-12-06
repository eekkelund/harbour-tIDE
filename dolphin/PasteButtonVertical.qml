// Copyright (C) 2015 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0


PasteButtonBase {
    id: pasteContainer

    Row {
        id: pasteRow

        height: parent.height
        anchors.horizontalCenter: parent.horizontalCenter

        Image {
            id: pasteIcon

            anchors.verticalCenter: parent.verticalCenter
            source: "image://theme/icon-m-clipboard"
                    + (pasteContainer.highlighted ? ("?" + Theme.highlightColor) : "")
        }

        Label {
            id: pasteLabel

            height: pasteContainer.height
            width: Math.min(pasteContainer.width - pasteIcon.width, implicitWidth)
            font { pixelSize: Theme.fontSizeSmall; family: Theme.fontFamily }
            color: pasteContainer.highlighted ? Theme.highlightColor : Theme.primaryColor
            truncationMode: TruncationMode.Fade
            verticalAlignment: Text.AlignVCenter
            maximumLineCount: 1
            text: Clipboard.text.replace("\n", " ")
        }

    }
}
