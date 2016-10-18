// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

CharacterKey {
    property string deadKeyAccents
    property string deadKeyAccentsShifted
    property string _deadKeyAccents: keyboard.isShifted ? deadKeyAccentsShifted : deadKeyAccents
    property int _deadAccentIndex: keyboard.deadKeyAccent !== "" ? _deadKeyAccents.indexOf(keyboard.deadKeyAccent) : -1
    property string _accentedText: _deadAccentIndex > -1 && !keyboard.inSymView ? _deadKeyAccents.substr(_deadAccentIndex+1, 1) : ""

    useBoldFont: _deadAccentIndex > -1
    keyType: _accentedText !== "" ? KeyType.PopupKey : KeyType.CharacterKey
    _keyText: _accentedText !== "" ? _accentedText :
                                    attributes.inSymView && symView.length > 0 ? (attributes.inSymView2 ? symView2 : symView)
                                                                               : (attributes.isShifted ? captionShifted : caption)
}
