// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2

Column {
    width: parent ? parent.width : 0

    property string type
    property bool portraitMode: visible ? keyboard.portraitMode : portraitMode
    property int keyHeight
    property int punctuationKeyWidth
    property int punctuationKeyWidthNarrow
    property int shiftKeyWidth
    property int spacebarKeyWidth
    property int functionKeyWidth
    property int shiftKeyWidthNarrow
    property int symbolKeyWidthNarrow
    property QtObject attributes: visible ? keyboard : keyboard.emptyAttributes
    property string languageCode
    property string inputMode

    Component.onCompleted: updateSizes()
    onWidthChanged: updateSizes()
    onPortraitModeChanged: updateSizes()

    function updateSizes () {
        if (width === 0) {
            return
        }

        if (portraitMode) {
            keyHeight = geometry.keyHeightPortrait
            punctuationKeyWidth = geometry.punctuationKeyPortait
            punctuationKeyWidthNarrow = geometry.punctuationKeyPortraitNarrow
            shiftKeyWidth = geometry.shiftKeyWidthPortrait
            spacebarKeyWidth = geometry.spacebarKeyWidthPortrait
            functionKeyWidth = geometry.functionKeyWidthPortrait
            shiftKeyWidthNarrow = geometry.shiftKeyWidthPortraitNarrow
            symbolKeyWidthNarrow = geometry.symbolKeyWidthPortraitNarrow
        } else {
            keyHeight = geometry.keyHeightLandscape
            punctuationKeyWidth = geometry.punctuationKeyLandscape
            punctuationKeyWidthNarrow = geometry.punctuationKeyLandscapeNarrow
            shiftKeyWidth = geometry.shiftKeyWidthLandscape
            spacebarKeyWidth = geometry.spacebarKeyWidthLandscape
            functionKeyWidth = geometry.functionKeyWidthLandscape
            shiftKeyWidthNarrow = geometry.shiftKeyWidthLandscapeNarrow
            symbolKeyWidthNarrow = geometry.symbolKeyWidthLandscapeNarrow
        }

        var i
        var child
        var maxButton = width

        for (i = 0; i < children.length; ++i) {
            child = children[i]
            child.width = width
            if (child.hasOwnProperty("basicButtonSize")) {
                child.height = keyHeight
            }

            if (child.maximumBasicButtonWidth !== undefined) {
                maxButton = Math.min(child.maximumBasicButtonWidth(width), maxButton)
            }
        }

        for (i = 0; i < children.length; ++i) {
            child = children[i]

            if (child.hasOwnProperty("basicButtonSize")) {
                child.basicButtonSize = maxButton
            }

            if (child.relayout !== undefined) {
                child.relayout()
            }
        }
    }
}
