// Copyright (C) 2013-2015 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0

PasteButtonBase {
    id: pasteContainer

    property int previewWidthLimit: Screen.width / 2

    Row {
        id: pasteRow
        height: parent.height
        anchors.right: parent.right
        anchors.rightMargin: Theme.paddingMedium

        Label {
            id: pasteLabel

            height: pasteContainer.height
            width: Math.min(pasteContainer.previewWidthLimit, implicitWidth)
            font { pixelSize: Theme.fontSizeSmall; family: Theme.fontFamily }
            color: pasteContainer.highlighted ? Theme.highlightColor : Theme.primaryColor
            truncationMode: TruncationMode.Fade
            verticalAlignment: Text.AlignVCenter
            maximumLineCount: 1
            text: Clipboard.text.replace("\n", " ")
        }

        Image {
            id: pasteIcon

            anchors.verticalCenter: parent.verticalCenter
            source: "image://theme/icon-m-clipboard"
                    + (pasteContainer.highlighted ? ("?" + Theme.highlightColor) : "")
        }
    }
}
