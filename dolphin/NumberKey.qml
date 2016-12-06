// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2

CharacterKey {
    property bool landscape

    captionShifted: caption
    showPopper: false
    height: geometry.keyHeightPortrait // not changing
    width: landscape ? geometry.keyboardWidthLandscape / 10
                     : geometry.keyboardWidthPortrait / 4
}
