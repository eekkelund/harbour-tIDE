// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import com.jolla.keyboard 1.0

QtObject {
    property bool _lastWasNumber
    property bool _doneInput

    function handleInput(key) {
        if (!key) {
            return
        }

        if (keyboard.inSymView
                && keyboard.lastInitialKey
                && keyboard.lastInitialKey.keyType === KeyType.SymbolKey
                && key.keyType === KeyType.CharacterKey
                && !keyboard.isPressed(KeyType.SymbolKey)) {
            keyboard.inSymView = false
            keyboard.inSymView2 = false
            return
        }

        if (!keyboard.inSymView
                || key.text === ""
                || keyboard.isPressed(KeyType.SymbolKey)) {
            return
        }

        if (key.text === " ") {
            if (_doneInput && !_lastWasNumber) {
                keyboard.inSymView = false
                keyboard.inSymView2 = false
            }
        } else if ("'@".indexOf(key.text) >= 0 && !_doneInput) {
            keyboard.inSymView = false
            keyboard.inSymView2 = false

        } else {
            _doneInput = true
            _lastWasNumber = "1234567890".indexOf(key.text) >= 0
        }
    }

    property variant _connection: Connections {
        target: keyboard
        onInSymViewChanged: {
            if (keyboard.inSymView) {
                _lastWasNumber = false
                _doneInput = false
            }
        }
    }
}
