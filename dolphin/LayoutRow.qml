// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2

Item {
    id: layoutRow

    property int nextActiveIndex: -1
    property Item layout: _loader1.item
    property LayoutLoader loader: _loader1
    property LayoutLoader nextLoader: _loader2
    property bool loading: _loader1.status === Loader.Loading || _loader2.status === Loader.Loading
    property alias transitionRunning: layoutTransition.running

    width: parent.width

    LayoutLoader {
        id: _loader1
        index: canvas.activeIndex
    }

    LayoutLoader {
        id: _loader2
    }

    SequentialAnimation {
        id: layoutTransition
        ParallelAnimation {
            NumberAnimation {
                duration: 200
                target: layoutRow.layout
                property: "x"
                to: layoutRow.loader ? -layoutRow.loader.width : 0
                easing.type: Easing.OutCubic
            }
            NumberAnimation {
                duration: 200
                target: layoutRow.nextLoader ? layoutRow.nextLoader.item : null
                property: "x"
                to: 0
                easing.type: Easing.OutCubic
            }
        }
        ScriptAction {
            script: {
                layoutRow.finalizeTransition()
                canvas.saveCurrentLayoutSetting()
            }
        }
    }

    function switchLayout(layoutIndex) {
        if (layoutIndex >= 0 && layoutIndex !== canvas.activeIndex) {
            nextActiveIndex = layoutIndex
            if (nextLoader.status === Loader.Loading) {
                // loader is already busy, queue the layout
                nextLoader.pendingIndex = layoutIndex
                return
            }
            nextLoader.visible = false
            nextLoader.index = layoutIndex
        }
    }

    function startTransition() {
        if (nextActiveIndex >= 0) {
            nextLoader.item.updateSizes()
            nextLoader.visible = true

            if (!MInputMethodQuick.active) {
                nextLoader.item.x = 0
                finalizeTransition()
            } else {
                nextLoader.item.x = loader.x + loader.width
                layoutTransition.start()
            }
        }
    }

    function finalizeTransition() {
        layoutRow.layout = layoutRow.nextLoader.item
        if (keyboard.inputHandler) {
            keyboard.inputHandler.active = false // this input handler might not handle new layout
        }
        canvas.activeIndex = layoutRow.nextActiveIndex
        keyboard.updateInputHandler()
        keyboard.resetKeyboard()
        keyboard.applyAutocaps()
        var oldLoader = layoutRow.loader
        layoutRow.loader = layoutRow.nextLoader
        layoutRow.nextLoader = oldLoader
        oldLoader.index = -1
    }
}
