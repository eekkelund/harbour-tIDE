// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import com.jolla.keyboard 1.0
import ".."

KeyboardRow {
    id: spacebarRow

    property alias deadKeyCaption: deadKey.caption
    property alias deadKeyCaptionShifted: deadKey.captionShifted

    splitIndex: 4

    SymbolKey {
        implicitWidth: symbolKeyWidthNarrow
    }
    DeadKey {
        id: deadKey
        implicitWidth: punctuationKeyWidthNarrow
        separator: SeparatorState.HiddenSeparator
    }
    ContextAwareCommaKey {
        implicitWidth: punctuationKeyWidthNarrow
    }
    SpacebarKey {}
    SpacebarKey {
        active: splitActive
        languageLabel: ""
    }
    CharacterKey {
        caption: "."
        captionShifted: "."
        implicitWidth: punctuationKeyWidthNarrow
        fixedWidth: !splitActive
        separator: SeparatorState.HiddenSeparator
    }
    EnterKey {}
}
