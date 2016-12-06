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

KeyBase {
    id: aCharKey

    property string captionShifted
    property string symView
    property string symView2
    property int separator: SeparatorState.AutomaticSeparator
    property bool implicitSeparator: true // set by layouting
    property bool showHighlight: true
    property string accents
    property string accentsShifted
    property string nativeAccents // accents considered native to the written language. not rendered.
    property string nativeAccentsShifted
    property bool fixedWidth
    property alias useBoldFont: primary.font.bold

    keyType: KeyType.CharacterKey
    text: primary.text
    keyText: primary.text

    Text {
        id: primary
        anchors.centerIn: parent
        anchors.horizontalCenterOffset: (leftPadding - rightPadding) / 2
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.family: Theme.fontFamily
        font.pixelSize: Theme.fontSizeLarge
        color: pressed ? Theme.highlightColor : Theme.primaryColor
        text: attributes.inSymView && symView.length > 0 ? (attributes.inSymView2 ? symView2 : symView)
                                                         : (attributes.isShifted ? captionShifted : caption)
    }

    Image {
        source: "graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
        visible: (separator === SeparatorState.AutomaticSeparator && implicitSeparator)
                 || separator === SeparatorState.VisibleSeparator
    }

    Rectangle {
        anchors.fill: parent
        z: -1
        color: Theme.highlightBackgroundColor
        opacity: 0.5
        visible: pressed && showHighlight
    }
}
