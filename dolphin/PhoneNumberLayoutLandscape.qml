// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0 as Silica

KeyboardLayout {
    id: main

    width: geometry.keyboardWidthLandscape
    height: 2 * geometry.keyHeightPortrait

    Row {
        CharacterKey {
            caption: "1"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            showPopper: false
        }
        PhoneKey {
            caption: "2"
            secondaryLabel: "abc"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            landscape: true
        }
        PhoneKey {
            caption: "3"
            secondaryLabel: "def"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            landscape: true
        }
        PhoneKey {
            caption: "4"
            secondaryLabel: "ghi"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            landscape: true
        }
        PhoneKey {
            caption: "5"
            secondaryLabel: "jkl"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            landscape: true
        }
        PhoneKey {
            caption: "6"
            secondaryLabel: "mno"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            landscape: true
        }
        PhoneKey {
            caption: "7"
            secondaryLabel: "pqrs"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            landscape: true
        }
        PhoneKey {
            caption: "8"
            secondaryLabel: "tuv"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            landscape: true
        }
        PhoneKey {
            caption: "9"
            secondaryLabel: "wxyz"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            landscape: true
        }
        CharacterKey {
            caption: "0"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            showPopper: false
            separator: false
        }
    }

    Row {
        x: 3 * (main.width / 10)

        NumberKey {
            landscape: true
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
        CharacterKey {
            key: Qt.Key_Multi_key
            text: "*p"
            caption: "*p"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            showPopper: false
        }
        CharacterKey {
            caption: "+"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            showPopper: false
        }
        CharacterKey {
            caption: "#"
            height: geometry.keyHeightPortrait
            width: main.width / 10
            showPopper: false
            separator: false
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
