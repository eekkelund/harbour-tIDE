// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.tide.keyboard 1.0

Column {
    id: layout

    width: parent ? parent.width : 0

    //Dolphin Keyboard

    property string primary: ""
    property string secondary: ""

    property Item settings: Settings {  }

    property Item primaryHandler
    property Item secondaryHandler

    property Item primaryHandlerLoader: Loader {
        onStatusChanged: {

           if ( primary !== "" && status === Loader.Ready ) {
               primaryHandler = primaryHandlerLoader.item
           }
        }
    }

    property Item secondaryHandlerLoader: Loader {
        onStatusChanged: {
            if ( secondary !== "" && status === Loader.Ready ) {
                secondaryHandler = secondaryHandlerLoader.item
            }
        }
    }

    //Prevent lag in switching keyboard
    Timer {
        id: timer
        interval: 256
        onTriggered: {
            if ( primary !== "" ) {
                primaryHandlerLoader.source = "/usr/share/maliit/plugins/com/jolla/layouts/" + primary + ".qml"
            }

            if ( secondary !== "" ) {
                secondaryHandlerLoader.source = "/usr/share/maliit/plugins/com/jolla/layouts/" + secondary + ".qml"
            }
        }

        Component.onCompleted: timer.start()
    }

    property bool xt9: keyboard.inputHandler !== secondaryHandler ? false : true

    function init() {

        if ( keyboard.allowLayoutChanges && primaryHandler && secondaryHandler ) {

            if ( keyboard.inputHandler !== primaryHandler || keyboard.inputHandler !== secondaryHandler ) {

                var oldHandler = keyboard.inputHandler
                oldHandler.active = false

                if ( settings.enMode === true && keyboard.inputHandler !== primaryHandler ) {

                    keyboard.inputHandler = primaryHandler
                    keyboard.inputHandler.active = true
                    console.warn("primaryHandler")

                } else if ( settings.enMode === true && keyboard.inputHandler !== secondaryHandler ) {

                    keyboard.inputHandler = secondaryHandler
                    keyboard.inputHandler.active = true
                    console.warn("secondaryHandler")
                }
            }
        }
    }

    Image {
        visible: settings.background !== "" ? true: false
        anchors.fill: parent
        parent: keyboard
        fillMode: Image.PreserveAspectCrop
        source: settings.background
        opacity: settings.transparency
        z: -4
    }

    Rectangle {
        z: -2
        visible: false
        parent: keyboard
        anchors.fill: parent
        gradient: Gradient {
            GradientStop { position: 0; color: Theme.rgba(Theme.highlightDimmerColor, 0.2) }
            GradientStop { position: 1; color: Theme.rgba(Theme.highlightBackgroundColor, 0.8) }
        }
    }
    property bool capsLockSupported: true
    property string type
    property bool portraitMode
    property int keyHeight
    property int punctuationKeyWidth
    property int punctuationKeyWidthNarrow
    property int shiftKeyWidth
    property int functionKeyWidth
    property int shiftKeyWidthNarrow
    property int symbolKeyWidthNarrow
    property QtObject attributes: visible ? keyboard : keyboard.emptyAttributes
    property string languageCode
    property string inputMode
    property int avoidanceWidth
    property bool splitActive
    property bool splitSupported
    property bool useTopItem: !splitActive

    Connections {
        target: MInputMethodQuick
        onCursorPositionChanged: {
            console.warn("onCursorPositionChanged")
        }

        onFocusTargetChanged: {
            console.warn("onFocusTargetChanged")
            //init()
        }

        onInputMethodReset: {
            console.warn("onInputMethodRest")
            //init()
        }
    }

    Connections {
        target: keyboard
        onFullyOpenChanged: {
            if ( keyboard.fullyOpen ) {
                console.warn("onFullyOpenChanged")
                //init()
            }
        }

        onSplitEnabledChanged: {
            console.warn("onSplitEnabledChanged")
            //init()
            updateSizes()
        }

    }

    Component.onCompleted: {
        console.warn("Component.onCompleted")
        updateSizes()
        //init()
    }

    onWidthChanged: {
        console.warn("onWidthChanged")
        updateSizes()
        //init()
    }

    onPortraitModeChanged: {
        console.warn("onPortraitModeChanged")
        updateSizes()
        //init()

    }

    Binding on portraitMode {
        when: visible
        value: keyboard.portraitMode
    }



    function updateSizes () {
        if ( width === 0 ) {
            return
        }

        if ( portraitMode ) {
            keyHeight = geometry.keyHeightPortrait * settings.scale
            punctuationKeyWidth = geometry.punctuationKeyPortait
            punctuationKeyWidthNarrow = geometry.punctuationKeyPortraitNarrow
            shiftKeyWidth = geometry.shiftKeyWidthPortrait
            functionKeyWidth = geometry.functionKeyWidthPortrait
            shiftKeyWidthNarrow = geometry.shiftKeyWidthPortraitNarrow
            symbolKeyWidthNarrow = geometry.symbolKeyWidthPortraitNarrow
            avoidanceWidth = 0
            splitActive = false
        } else {
            keyHeight = geometry.keyHeightLandscape * settings.scale
            punctuationKeyWidth = geometry.punctuationKeyLandscape
            punctuationKeyWidthNarrow = geometry.punctuationKeyLandscapeNarrow
            functionKeyWidth = geometry.functionKeyWidthLandscape

            var shouldSplit = keyboard.splitEnabled && splitSupported
            if ( shouldSplit ) {
                avoidanceWidth = geometry.middleBarWidth
                shiftKeyWidth = geometry.shiftKeyWidthLandscapeSplit
                shiftKeyWidthNarrow = geometry.shiftKeyWidthLandscapeSplit
                symbolKeyWidthNarrow = geometry.symbolKeyWidthLandscapeNarrowSplit
            } else {
                avoidanceWidth = 0
                shiftKeyWidth = geometry.shiftKeyWidthLandscape
                shiftKeyWidthNarrow = geometry.shiftKeyWidthLandscapeNarrow
                symbolKeyWidthNarrow = geometry.symbolKeyWidthLandscapeNarrow
            }
            splitActive = shouldSplit
        }

        var i
        var child
        var maxButton = width

        for (i = 0; i < children.length; ++i) {
            child = children[i]
            child.width = width
            if (child.hasOwnProperty("followRowHeight") && child.followRowHeight) {
                child.height = keyHeight
            }

            if (child.maximumBasicButtonWidth !== undefined) {
                maxButton = Math.min(child.maximumBasicButtonWidth(width), maxButton)
            }
        }

        for (i = 0; i < children.length; ++i) {
            child = children[i]

            if (child.relayout !== undefined) {
                child.relayout(maxButton)
            }
        }
    }
}
