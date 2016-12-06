// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import com.meego.maliitquick 1.0

CharacterKey {
    id: deadKey

    property int _charactersWhenPressed
    property bool _quickPicking

    keyType: !keyboard.inSymView ? KeyType.DeadKey : KeyType.CharacterKey
    useBoldFont: keyboard.deadKeyAccent === text
    showPopper: keyType === KeyType.CharacterKey
    fixedWidth: !splitActive
    implicitWidth: punctuationKeyWidth

    onPressedChanged: {
        if (pressed
             && !keyboard.inSymView
             && keyboard.deadKeyAccent !== text
             && keyboard.lastInitialKey === deadKey) {
            keyboard.deadKeyAccent = text
            _quickPicking = true
        } else {
            _quickPicking = false
        }

        _charactersWhenPressed = keyboard.characterKeyCounter
    }

    onClicked: {
        if (keyboard.characterKeyCounter > _charactersWhenPressed) {
            keyboard.deadKeyAccent = ""
            keyboard.updatePopper()
        } else if (!_quickPicking) {
            if (keyboard.deadKeyAccent !== text && !keyboard.inSymView) {
                keyboard.deadKeyAccent = text
            } else {
                keyboard.deadKeyAccent = ""
            }
        }
    }
}
