// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0 as Silica

KeyboardLayout {
    id: main

    width: geometry.keyboardWidthLandscape
    height: 2 * geometry.keyHeightPortrait

    Row {
        NumberKey {
            caption: "1"
            landscape: true
        }
        NumberKey {
            caption: "2"
            landscape: true
        }
        NumberKey {
            caption: "3"
            landscape: true
        }
        NumberKey {
            caption: "4"
            landscape: true
        }
        NumberKey {
            caption: "5"
            landscape: true
        }
        NumberKey {
            caption: "6"
            landscape: true
        }
        NumberKey {
            caption: "7"
            landscape: true
        }
        NumberKey {
            caption: "8"
            landscape: true
        }
        NumberKey {
            caption: "9"
            landscape: true
        }
        NumberKey {
            caption: "0"
            landscape: true
            separator: false
        }
    }

    Row {
        x: 2 * (main.width / 10)

        NumberKey {
            landscape: true
            enabled: Silica.Clipboard.hasText
            opacity: enabled ? (pressed ? 0.6 : 1.0)
                             : 0.3
            key: Qt.Key_Paste

            Image {
                anchors.centerIn: parent
                source: "image://theme/icon-m-clipboard?"
                        + (parent.pressed ? Silica.Theme.highlightColor : Silica.Theme.primaryColor)
            }
        }
        NumberKey {
            landscape: true
            key: Qt.Key_Multi_key
            caption: "+/-"
            text: "+-"
        }
        NumberKey {
            landscape: true
            caption: Qt.locale().decimalPoint
            separator: false
        }
        SpacebarKey {
            width: main.width / 5
            height: geometry.keyHeightPortrait
        }
        BackspaceKey {
            width: main.width / 10
            height: geometry.keyHeightPortrait
        }
        EnterKey {
            width: main.width / 5
            height: geometry.keyHeightPortrait
        }
    }
}
