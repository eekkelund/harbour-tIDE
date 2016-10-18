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
        PhoneKey {
            caption: "1"
            height: geometry.keyHeightPortrait
            width: main.width / 4

        }
        PhoneKey {
            caption: "2"
            secondaryLabel: "abc"
            height: geometry.keyHeightPortrait
            width: main.width / 4
        }
        PhoneKey {
            caption: "3"
            secondaryLabel: "def"
            height: geometry.keyHeightPortrait
            width: main.width / 4
        }
        NumberKey {
            separator: false
            enabled: Silica.Clipboard.hasText
            key: Qt.Key_Paste
            opacity: enabled ? (pressed ? 0.6 : 1.0)
                             : 0.3

            Image {
                anchors.centerIn: parent
                source: "image://theme/icon-m-clipboard?"
                        + (parent.pressed ? Silica.Theme.highlightColor : Silica.Theme.primaryColor)
            }
        }
    }

    Row {
        PhoneKey {
            caption: "4"
            secondaryLabel: "ghi"
            height: geometry.keyHeightPortrait
            width: main.width / 4
        }
        PhoneKey {
            caption: "5"
            secondaryLabel: "jkl"
            height: geometry.keyHeightPortrait
            width: main.width / 4
        }
        PhoneKey {
            caption: "6"
            secondaryLabel: "mno"
            height: geometry.keyHeightPortrait
            width: main.width / 4
        }
        CharacterKey {
            key: Qt.Key_Multi_key
            text: "*p"
            caption: "*p"
            height: geometry.keyHeightPortrait
            width: main.width / 4
            showPopper: false
            separator: false
        }
    }

    Row {
        PhoneKey {
            caption: "7"
            secondaryLabel: "pqrs"
            height: geometry.keyHeightPortrait
            width: main.width / 4
        }
        PhoneKey {
            caption: "8"
            secondaryLabel: "tuv"
            height: geometry.keyHeightPortrait
            width: main.width / 4
        }
        PhoneKey {
            caption: "9"
            secondaryLabel: "wxyz"
            height: geometry.keyHeightPortrait
            width: main.width / 4
        }
        BackspaceKey {
            width: main.width / 4
            height: geometry.keyHeightPortrait
            separator: false
        }
    }

    Row {
        CharacterKey {
            caption: "+"
            height: geometry.keyHeightPortrait
            width: main.width / 4
            showPopper: false
        }
        CharacterKey {
            caption: "0"
            height: geometry.keyHeightPortrait
            width: main.width / 4
            showPopper: false
        }
        CharacterKey {
            caption: "#"
            height: geometry.keyHeightPortrait
            width: main.width / 4
            showPopper: false
        }
        EnterKey {
            width: main.width / 4
            height: geometry.keyHeightPortrait
            separator: false
        }
    }
}
