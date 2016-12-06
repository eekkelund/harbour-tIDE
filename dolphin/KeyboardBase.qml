/*
 * Copyright (C) 2012-2013 Jolla Ltd.
 * Copyright (C) 2012 John Brooks <john.brooks@dereferenced.net>
 * Copyright (C) Jakub Pavelek <jpavelek@live.com>
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Nokia Corporation nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

import QtQuick 2.2
import Sailfish.Silica 1.0
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0
import org.nemomobile.configuration 1.0
import "touchpointarray.js" as ActivePoints

Item {
    id: keyboard

    property Item layout
    property bool portraitMode

    property Item lastPressedKey
    property Item lastInitialKey

    property int shiftState: ShiftState.AutoShift
    property bool autocaps
    // TODO: should clean up autocaps handling
    readonly property bool isShifted: shiftKeyPressed
                                      || shiftState === ShiftState.LatchedShift
                                      || shiftState === ShiftState.LockedShift
                                      || (shiftState === ShiftState.AutoShift && autocaps
                                          && (typeof inputHandler.preedit !== "string"
                                              || inputHandler.preedit.length === 0))
    readonly property bool isShiftLocked: shiftState === ShiftState.LockedShift

    property bool inSymView
    property bool inSymView2
    // allow chinese input handler to override enter key state
    property bool chineseOverrideForEnter

    property bool layoutChangeAllowed
    property string deadKeyAccent
    property bool shiftKeyPressed
    // counts how many character keys have been pressed since the ActivePoints array was empty
    property int characterKeyCounter
    property bool closeSwipeActive
    property int closeSwipeThreshold: Math.max(height*.3, Theme.itemSizeSmall)

    property QtObject emptyAttributes: Item {
        property bool isShifted
        property bool inSymView
        property bool inSymView2
        property bool isShiftLocked
        property bool chineseOverrideForEnter
    }

    // Can be changed to PreeditTestHandler to have another mode of input
    property Item inputHandler: InputHandler {
    }

    height: layout ? layout.height : 0
    onLayoutChanged: if (layout) layout.parent = keyboard
    onPortraitModeChanged: cancelAllTouchPoints()

    // if height changed while touch point was being held
    // we can't rely on point values anymore
    onHeightChanged: closeSwipeActive = false

    Popper {
        id: popper
        z: 10
        target: lastPressedKey
    }

    LanguageSelectionPopup {
        id: languageSelectionPopup
        z: 11
    }

    Timer {
        id: pressTimer
        interval: 500
    }

    Timer {
        id: languageSwitchTimer
        interval: 500
        onTriggered: {
            if (canvas.layoutModel.enabledCount > 1) {
                var point = ActivePoints.findByKeyId(Qt.Key_Space)
                languageSelectionPopup.show(point)
            }
        }
    }

    QuickPick {
        id: quickPick
    }

    Connections {
        target: MInputMethodQuick
        onCursorPositionChanged: {
            if (MInputMethodQuick.surroundingTextValid) {
                applyAutocaps()

                if (shiftState !== ShiftState.LockedShift) {
                    resetShift()
                }
            }
        }
        onFocusTargetChanged: {
            if (activeEditor) {
                resetKeyboard()
                applyAutocaps()
            }
        }
        onInputMethodReset: {
            inputHandler._reset()
        }
    }

    ConfigurationValue {
        id: useMouseEvents
        key: "/sailfish/text_input/use_mouse_events"
        defaultValue: false
    }

    MouseArea {
        enabled: useMouseEvents.value
        anchors.fill: parent

        onPressed: keyboard.handlePressed(createPointArray(mouse.x, mouse.y))
        onPositionChanged: keyboard.handleUpdated(createPointArray(mouse.x, mouse.y))
        onReleased: keyboard.handleReleased(createPointArray(mouse.x, mouse.y))
        onCanceled: keyboard.cancelAllTouchPoints()

        function createPointArray(pointX, pointY) {
            var pointArray = new Array
            pointArray.push({"pointId": 1, "x": pointX, "y": pointY,
                             "startX": pointX, "startY": pointY })
            return pointArray
        }
    }

    MultiPointTouchArea {
        anchors.fill: parent
        enabled: !useMouseEvents.value

        onPressed: keyboard.handlePressed(touchPoints)
        onUpdated: keyboard.handleUpdated(touchPoints)
        onReleased: keyboard.handleReleased(touchPoints)
        onCanceled: keyboard.handleCanceled(touchPoints)
    }

    function handlePressed(touchPoints) {
        if (languageSelectionPopup.visible) {
            return
        }

        closeSwipeActive = true
        pressTimer.start()

        for (var i = 0; i < touchPoints.length; i++) {
            var point = ActivePoints.addPoint(touchPoints[i])
            updatePressedKey(point)
        }
    }

    function handleUpdated(touchPoints) {
        if (languageSelectionPopup.visible) {
            languageSelectionPopup.handleMove(touchPoints[0])
            return
        }

        for (var i = 0; i < touchPoints.length; i++) {
            var incomingPoint = touchPoints[i]
            var point = ActivePoints.findById(incomingPoint.pointId)
            if (point === null)
                continue

            point.x = incomingPoint.x
            point.y = incomingPoint.y

            if (ActivePoints.array.length === 1
                    && closeSwipeActive
                    && pressTimer.running
                    && (point.y - point.startY > closeSwipeThreshold)) {
                MInputMethodQuick.userHide()
                if (point.pressedKey) {
                    inputHandler._handleKeyRelease()
                    point.pressedKey.pressed = false
                }
                lastPressedKey = null
                pressTimer.stop()
                languageSwitchTimer.stop()
                ActivePoints.remove(point)
                return
            }

            if (popper.expanded && point.pressedKey === lastPressedKey) {
                popper.setActiveCell(point.x, point.y)
            } else {
                updatePressedKey(point)
            }
        }
    }

    function updatePressedKey(point) {
        var key = keyAt(point.x, point.y)
        if (point.pressedKey === key)
            return

        buttonPressEffect.play()

        if (key) {
            if (typeof key.keyType !== 'undefined' && key.keyType === KeyType.CharacterKey && key.text !== " ") {
                SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
            } else {
                SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_option.wav")
            }
        }

        if (point.pressedKey !== null)
            point.pressedKey.pressed = false

        point.pressedKey = key
        if (!point.initialKey) {
            point.initialKey = point.pressedKey
            lastInitialKey = point.initialKey
        }

        languageSwitchTimer.stop()
        lastPressedKey = point.pressedKey

        if (point.pressedKey !== null) {
            releasePreviousCharacterKey(point)
            point.pressedKey.pressed = true
            inputHandler._handleKeyPress(point.pressedKey)
            if (point.pressedKey.key === Qt.Key_Space && layoutChangeAllowed)
                languageSwitchTimer.start()
        }
    }

    function handleReleased(touchPoints) {
        if (languageSelectionPopup.visible) {
            if (languageSelectionPopup.opening) {
                languageSelectionPopup.hide()
            } else {
                cancelAllTouchPoints()
                languageSelectionPopup.hide()
                canvas.switchLayout(languageSelectionPopup.activeCell)
                return
            }
        }

        for (var i = 0; i < touchPoints.length; i++) {
            var point = ActivePoints.findById(touchPoints[i].pointId)
            if (point === null)
                continue

            if (point.pressedKey === null) {
                ActivePoints.remove(point)
                continue
            }

            if (popper.expanded && point.pressedKey === lastPressedKey) {
                popper.release()
                point.pressedKey.pressed = false
            } else {
                releaseKey(point.pressedKey)
            }

            if (point.pressedKey.keyType !== KeyType.ShiftKey && !isPressed(KeyType.DeadKey)) {
                deadKeyAccent = ""
            }
            if (point.pressedKey === lastPressedKey) {
                lastPressedKey = null
            }

            ActivePoints.remove(point)
        }

        if (ActivePoints.array.length === 0) {
            characterKeyCounter = 0
        }
        languageSwitchTimer.stop()
    }

    function handleCanceled(touchPoints) {
        for (var i = 0; i < touchPoints.length; i++) {
            cancelTouchPoint(touchPoints[i].pointId)
        }
    }

    function keyAt(x, y) {
        if (layout === null)
            return null

        var item = layout

        x -= layout.x
        y -= layout.y

        while ((item = item.childAt(x, y)) != null) {
            if (typeof item.keyType !== 'undefined' && item.enabled === true) {
                return item
            }

            // Cheaper mapToItem, assuming we're not using anything fancy.
            x -= item.x
            y -= item.y
        }

        return null
    }

    function cancelTouchPoint(pointId) {
        var point = ActivePoints.findById(pointId)
        if (!point)
            return

        if (point.pressedKey) {
            point.pressedKey.pressed = false
            if (lastPressedKey === point.pressedKey) {
                lastPressedKey = null
            }
        }
        if (lastInitialKey === point.initialKey) {
            lastInitialKey = null
        }

        languageSwitchTimer.stop()
        languageSelectionPopup.hide()

        ActivePoints.remove(point)
    }

    function cancelAllTouchPoints() {
        while (ActivePoints.array.length > 0) {
            cancelTouchPoint(ActivePoints.array[0].pointId)
        }
    }

    function resetKeyboard() {
        cancelAllTouchPoints()

        inSymView = false
        inSymView2 = false

        resetShift()
        inputHandler._reset()

        lastPressedKey = null
        lastInitialKey = null
        deadKeyAccent = ""
    }

    function applyAutocaps() {
        if (MInputMethodQuick.surroundingTextValid
                && MInputMethodQuick.contentType === Maliit.FreeTextContentType
                && MInputMethodQuick.autoCapitalizationEnabled
                && !MInputMethodQuick.hiddenText
                && layout && layout.type === "") {
            var position = MInputMethodQuick.cursorPosition
            var text = MInputMethodQuick.surroundingText.substring(0, position)

            if (position == 0
                    || (position == 1 && text[0] === " ")
                    || (position >= 2 && text[position - 1] === " "
                        && ".?!".indexOf(text[position - 2]) >= 0)) {
                autocaps = true
            } else {
                autocaps = false
            }
        } else {
            autocaps = false
        }
    }

    function cycleShift() {
        if (shiftState === ShiftState.NoShift) {
            shiftState = ShiftState.LatchedShift
        } else if (shiftState === ShiftState.LatchedShift) {
            shiftState = ShiftState.LockedShift
        } else if (shiftState === ShiftState.LockedShift) {
            shiftState = ShiftState.NoShift
        } else {
            // exiting automatic shift state
            if (autocaps) {
                shiftState = ShiftState.NoShift
            } else {
                shiftState = ShiftState.LatchedShift
            }
        }
    }

    function resetShift() {
        if (!shiftKeyPressed) {
            shiftState = ShiftState.AutoShift
        }
    }

    function toggleSymbolMode() {
        // Cancel everything else except one symbol key point.
        while (ActivePoints.array.length > 1) {
            var point = ActivePoints.array[0]
            if (point.pressedKey && point.pressedKey.keyType === KeyType.SymbolKey) {
                 point = ActivePoints.array[1]
            }
            cancelTouchPoint(point.pointId)
        }

        inSymView = !inSymView
        if (!inSymView) {
            inSymView2 = false
        }
    }

    function existingCharacterKey(updatedPoint) {
        for (var i = 0; i < ActivePoints.array.length; i++) {
            var point = ActivePoints.array[i]
            if (point !== updatedPoint
                    && point.pressedKey
                    && point.pressedKey.keyType === KeyType.CharacterKey) {
                return point
            }
        }
    }

    function releasePreviousCharacterKey(updatedPoint) {
        var existing = existingCharacterKey(updatedPoint)
        if (existing) {
            releaseKey(existing.pressedKey)
            ActivePoints.remove(existing)
        }
    }

    function releaseKey(key) {
        if (key.keyType !== KeyType.DeadKey) {
            inputHandler._handleKeyClick(key)
        }
        key.clicked()
        inputHandler._handleKeyRelease()
        quickPick.handleInput(key)
        key.pressed = false
    }

    function isPressed(keyType) {
        return ActivePoints.findByKeyType(keyType) !== null
    }

    function updatePopper() {
        if (!popper.expanded) {
            var pressedKey = lastPressedKey
            lastPressedKey = null
            lastPressedKey = pressedKey
        }
    }
}
