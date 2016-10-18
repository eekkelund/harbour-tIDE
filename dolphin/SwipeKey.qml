/*
 * Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies). All rights reserved.
 * Copyright (C) 2012-2013 Jolla Ltd.
 *
 * Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>
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
import QtMultimedia 5.0
import Sailfish.Silica 1.0

KeyBase {
    id: aCharKey

    property string captionShifted
    property string symView
    property string symView2
    property bool separator: true
    property bool showHighlight: true
    property string accents
    property string accentsShifted
    property string nativeAccents // accents considered native to the written language. not rendered.
    property string nativeAccentsShifted
    property bool fixedWidth
    property alias useBoldFont: keyText.font.bold
    property alias  _keyText: keyText.text

    //keyType: KeyType.CharacterKey
    text: keyText.text

    Text {
        id: keyText
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: (leftPadding - rightPadding) / 2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        textFormat: Text.PlainText
        font.pixelSize: Theme.fontSizeSmall * settings.scale
        color: pressed ? Theme.highlightColor : Theme.primaryColor
        text: attributes.inSymView && symView.length > 0 ? (attributes.inSymView2 ? symView2 : symView)
                                                         : (attributes.isShifted ? captionShifted : caption)
    }

    Image {
        source: "graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
        visible: separator
    }

    Rectangle {
        anchors.fill: parent
        z: -1
        color: Theme.highlightBackgroundColor
        opacity: 0.5
        visible: pressed && showHighlight
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        //propagateComposedEvents: keyboard.inputHandler === xt9Handler? true: false
        //visible: keyboard.inputHandler === xt9Handler? true: false
        //propagateComposedEvents: true
        //visible: true
        z: 1024
        propagateComposedEvents: true
        property int keyType: KeyType.CharacterKey

        property int angle: 0
        property int distance: 0
        property bool autoRepeat: false
        property point start: Qt.point(0, 0);
        property int threshold: 16 * (height * 2 > width ? 2 : 1 )

        property bool swipeT: false
        property bool swipeB: false
        property bool swipeL: false
        property bool swipeR: false


        onPressed: {
            effectP.play()
            start = Qt.point(mouse.x, mouse.y)
            angle = 0
            distance = 0
            var pos = mapToItem(layout, mouse.x, mouse.y)
        }

        SoundEffect {
            id: effectP
            source: "/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav"
        }

        SoundEffect {
            id: effectR
            source: "/usr/share/sounds/jolla-ambient/stereo/keyboard_option.wav"
        }

        onClicked: {
            keyboard.inputHandler.handleKey(keyText.text)
            buttonPressEffect.play()
            console.warn("SwipeKey")
            mouse.accepted = false
        }

        onReleased: {
            buttonPressEffect.play()
            effectR.play()
            var pos = mapToItem(layout, mouse.x, mouse.y)

            if ( swipeR === true ) {

            } else {
                inEmojiView = false
            }

        }

        onPositionChanged: {

            angle = Math.atan2(mouse.y - start.y, mouse.x - start.x) * 360 / Math.PI / 2 + 180
            var d = Math.sqrt(Math.pow(mouse.x - start.x, 2) + Math.pow(mouse.y - start.y, 2))
            distance = Math.round(d / threshold)
            var pos = mapToItem(layout, mouse.x, mouse.y)

            if ( distance > 2 && angle >= 45 && angle <= 134 ) {
                swipeT = true

            } else if ( distance >= 0 && angle >= 135 && angle <= 214 ) {

                inEmojiView = true
                keyboard.layout.transition = distance / 4
                if ( distance / 4 >= 1 ) {
                    swipeR = true
                } else {
                    swipeR = false
                }

            } else if ( distance > 2 && angle >= 215 && angle <= 304 ) {
                swipeB = true

            } else if ( distance > 2 ) {
                swipeL = true

            } else {

            }
        }

        //BACKGROUND
        Rectangle {
            color: parent.pressed ? Theme.highlightBackgroundColor : "#00000000"
            anchors.fill: parent
            opacity: 0.4
        }

        Rectangle {
            id: popper
            visible: parent.pressed? true: false
            anchors.bottom: parent.top
            color: Qt.darker(Theme.highlightBackgroundColor, 1.2)
            width: parent.width
            height: parent.height
            radius: geometry.popperRadius

            Label {
                anchors.centerIn: parent
                text: keyText.text
            }
        }
    }
}
