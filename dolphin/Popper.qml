/*
 * Copyright (C) Jakub Pavelek <jpavelek@live.com>
 * Copyright (C) 2013 Jolla Ltd.
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
import com.jolla.keyboard 1.0
import Sailfish.Silica 1.0

Rectangle {
    id: popper
    opacity: 0
    color: Qt.darker(Theme.highlightBackgroundColor, 1.2)
    height: geometry.popperHeight
    width: geometry.popperWidth
    radius: geometry.popperRadius
    clip: expanded

    property Item target: null
    property int activeCell
    property int initialActiveCell
    property real expandedWidth
    property real expandedX
    property bool expanded
    property real activeX

    onTargetChanged: {
        expanded = false
        if (target && target.showPopper) {
            popperExpandTimer.restart()
            setup()
        } else {
            popperExpandTimer.stop()
        }
    }

    ListModel {
        id: accents
    }

    Row {
        id: contentRow
        height: parent.height

        Repeater {
            model: accents
            PopperCell {
                character: labelText
                active: index === popper.activeCell
                textVisible: popper.expanded || index === popper.activeCell
            }
        }
    }
    Timer {
        id: popperExpandTimer
        interval: 500
        onTriggered: {
            if (accents.count > 1 || geometry.isLargeScreen) {
                keyboard.inputHandler._handleKeyRelease()
                popper.expanded = true
            }
        }
    }

    KeyBase {
        // using one element for updating input handler
        id: inputKey
        keyType: KeyType.PopupKey
    }

    states: [
        State {
            name: "active"
            when: target !== null && target.showPopper && !popper.expanded && !geometry.isLargeScreen

            PropertyChanges {
                target: popper
                opacity: 1
                x: popper.activeX
            }
        },
        State {
            name: "expanded"
            when: target !== null && target.showPopper && popper.expanded

            PropertyChanges {
                target: popper
                opacity: 1
                x: {
                    var result = initialActiveCell > 0 ? popper.expandedX : popper.activeX
                    var margin = geometry.popperMargin
                    return Math.max(margin,
                                    Math.min(result,
                                             parent.width-popper.expandedWidth-margin))
                }
                width: popper.expandedWidth
            }
            PropertyChanges {
                target: contentRow
                x: geometry.accentPopperMargin
            }
        }
    ]

    transitions: [
        Transition {
            from: "active"
            to: ""

            SequentialAnimation {
                PauseAnimation { duration: 20 }
                PropertyAction {
                    target: popper
                    properties: "opacity, x"
                }
                ScriptAction {
                    script: {
                        accents.clear()
                        popper.opacity = 0
                    }
                }
            }
        },
        Transition {
            from: "expanded"
            to: ""
            SequentialAnimation {
                PropertyAction {
                    target: popper
                    properties: "opacity, x"
                }
                ScriptAction {
                    script: {
                        accents.clear()
                        popper.expanded = false
                        popper.opacity = 0
                    }
                }
            }
        },
        Transition {
            from: "active"
            to: "expanded"

            ParallelAnimation {
                NumberAnimation {
                    target: popper
                    properties: "x,width"
                    duration: 100
                    easing.type: Easing.OutQuad
                }
                NumberAnimation {
                    target: contentRow
                    properties: "x"
                    duration: 100
                    easing.type: Easing.OutQuad
                }
            }
        }
    ]

    function release() {
        if (activeCell < 0) {
            return
        }

        inputKey.text = accents.get(activeCell).inputText
        keyboard.inputHandler._handleKeyPress(inputKey)
        keyboard.inputHandler._handleKeyClick(inputKey)
        keyboard.inputHandler._handleKeyRelease(inputKey)
    }

    function setActiveCell(mouseX, mouseY) {
        var oldActiveCell = activeCell
        var xPos = mouseX - x - geometry.accentPopperMargin
        if (xPos >= 0 && xPos < width-2*geometry.accentPopperMargin)
            activeCell = Math.floor(xPos / geometry.accentPopperCellWidth)
        else activeCell = -1
        if (activeCell !== oldActiveCell && activeCell !== -1) {
            SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
            buttonPressEffect.play()
        }
    }
    function setup() {
        // layout out everything ready so that after a long press we can just animate
        y = popper.parent.mapFromItem(target, 0, 0).y - popper.height + Theme.paddingSmall
        var pos = popper.parent.mapFromItem(target, 0, 0).x + (target.width - popper.width) / 2
        var margin = geometry.popperMargin
        activeX = Math.max(Math.min(pos, parent.width - popper.width - margin), margin)

        var accentString = (keyboard.inSymView || keyboard.inSymView2)
                           ? "" : keyboard.isShifted ? target.accentsShifted
                                                     : target.accents
        // target key accent added separately, remove now. (TODO: could remove from layouts too)
        accentString = accentString.replace(target.text, "")
        var itemCount = accentString.length + 1

        popper.expandedWidth = itemCount * geometry.accentPopperCellWidth +
                               2 * geometry.accentPopperMargin

        // calculate expanded position and make sure we stay inside the vkb area
        var middleCell = Math.floor((itemCount-1) * .5)
        var mappedTargetX = parent.mapFromItem(target, 0, 0).x +
                            Math.floor((target.width - geometry.accentPopperCellWidth) / 2)

        popper.expandedX = mappedTargetX -
                           geometry.accentPopperMargin -
                           (middleCell * geometry.accentPopperCellWidth)
        popper.expandedX = Math.max(geometry.popperMargin,
                                    Math.min(expandedX,
                                             parent.width-popper.expandedWidth-geometry.popperMargin))

        // calculate active cell
        var translatedX = mappedTargetX + target.width * .5 - expandedX - geometry.accentPopperMargin
        translatedX = Math.max(Math.min(translatedX,
                               expandedWidth-2*geometry.accentPopperMargin-0.1), 0)
        activeCell = Math.floor(translatedX / geometry.accentPopperCellWidth)
        initialActiveCell = activeCell

        // TODO: support separate visual and input text on accents
        accents.clear()
        for (var i = 0; i < accentString.length; ++i) {
            accents.append({ "labelText": accentString.charAt(i), "inputText": accentString.charAt(i) })
        }
        accents.insert(activeCell, { "labelText": target.keyText, "inputText": target.text } )

        // position content row so that the base character is visible and centered
        contentRow.x = popper.radius -
                       popper.activeCell * geometry.accentPopperCellWidth +
                       Math.floor((popper.width - 2 * popper.radius - geometry.accentPopperCellWidth) * .5)
    }
}
