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
import Sailfish.Silica 1.0



MouseArea {
    id: mouseArea
    parent: keyboard
    anchors.fill: parent
     propagateComposedEvents: true
     preventStealing: true
    property int angle: 0
    property int distance: 0
    property bool autoRepeat: false
    property point start: Qt.point(0, 0);
    property int threshold: 16 * (height * 2 > width ? 2 : 1 )

    property bool swipeT: false
    property bool swipeB: false
    property bool swipeL: false
    property bool swipeR: false
     z: 2048

    onPressed: {
        start = Qt.point(mouse.x, mouse.y)
        angle = 0
        distance = 0
        var pos = mapToItem(layout, mouse.x, mouse.y)
    }

    onClicked: {
        root.clicked()
        console.warn("SwipeKey")
        mouse.accepted = false
    }

    onReleased: {

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
            console.warn("XXXXXXXXXXXXXXXXXXXXXXXx")
        } else if ( distance >= 0 && angle >= 135 && angle <= 214 ) {

            //inEmojiView = true
            if ( distance / 4 >= 1 ) {
                swipeR = true
                console.warn("XXXXXXXXXXXXXXXXXXXXXXXx")
            } else {
                swipeR = false
                console.warn("XXXXXXXXXXXXXXXXXXXXXXXx")
            }

        } else if ( distance > 2 && angle >= 215 && angle <= 304 ) {
            swipeB = true
            console.warn("XXXXXXXXXXXXXXXXXXXXXXXx")
        } else if ( distance > 2 ) {
            swipeL = true
            console.warn("XXXXXXXXXXXXXXXXXXXXXXXx")
        } else {

        }
    }

}
