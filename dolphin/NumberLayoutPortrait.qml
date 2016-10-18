// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0 as Silica

KeyboardLayout {
    id: main

    portraitMode: true
    width: geometry.keyboardWidthPortrait
    height: 4 * geometry.keyHeightPortrait

    Row {
        NumberKey {
            caption: "1"
        }
        NumberKey {
            caption: "2"
        }
        NumberKey {
            caption: "3"
        }
        NumberKey {
            enabled: Silica.Clipboard.hasText
            separator: false
            opacity: enabled ? (pressed ? 0.6 : 1.0)
                             : 0.3
            key: Qt.Key_Paste

            Image {
                anchors.centerIn: parent
                source: "image://theme/icon-m-clipboard?"
                        + (parent.pressed ? Silica.Theme.highlightColor : Silica.Theme.primaryColor)
            }
        }
    }

    Row {
        NumberKey {
            caption: "4"
        }
        NumberKey {
            caption: "5"
        }
        NumberKey {
            caption: "6"
        }
        NumberKey {
            separator: false
            key: Qt.Key_Multi_key
            caption: "+/-"
            text: "+-"
        }
    }

    Row {
        NumberKey {
            caption: "7"
        }
        NumberKey {
            caption: "8"
        }
        NumberKey {
            caption: "9"
        }
        BackspaceKey {
            width: main.width / 4
            height: geometry.keyHeightPortrait
            separator: false
        }
    }

    Row {
        NumberKey {
            caption: Qt.locale().decimalPoint
        }
        NumberKey {
            caption: "0"
        }
        SpacebarKey {
            width: main.width / 4
            height: geometry.keyHeightPortrait
        }
        EnterKey {
            width: main.width / 4
            height: geometry.keyHeightPortrait
            separator: false
        }
    }
}
