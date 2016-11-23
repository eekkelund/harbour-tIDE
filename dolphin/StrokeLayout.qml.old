/*
 * Copyright (C) 2014 Jolla ltd and/or its subsidiary(-ies). All rights reserved.
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
 * Neither the name of Jolla Ltd nor the names of its contributors may be
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
import "."

KeyboardLayout {
    type: "china_stroke"

    KeyboardRow {
        visible: keyboard.inSymView

        CharacterKey { symView: "1"; symView2: "@" }
        CharacterKey { symView: "2"; symView2: "/" }
        CharacterKey { symView: "3"; symView2: "\\" }
        CharacterKey { symView: "4"; symView2: "~" }
        CharacterKey { symView: "5"; symView2: "^" }
        CharacterKey { symView: "6"; symView2: "_" }
        CharacterKey { symView: "7"; symView2: "¥" }
        CharacterKey { symView: "8"; symView2: "€" }
        CharacterKey { symView: "9"; symView2: "$" }
        CharacterKey { symView: "0"; symView2: "£" }
    }

    KeyboardRow {
        visible: keyboard.inSymView

        CharacterKey { symView: "*"; symView2: "§" }
        CharacterKey { symView: "#"; symView2: "=" }
        CharacterKey { symView: "+"; symView2: "〈" }
        CharacterKey { symView: "-"; symView2: "〉" }
        CharacterKey { symView: "（"; symView2: "(" }
        CharacterKey { symView: "）"; symView2: ")" }
        CharacterKey { symView: "—"; symView2: "《" }
        CharacterKey { symView: "…"; symView2: "》" }
        CharacterKey { symView: "%"; symView2: "&" }
        CharacterKey { symView: "'"; symView2: "\"" }
    }

    KeyboardRow {
        id: centerRow
        visible: keyboard.inSymView

        ShiftKey {  }

        CharacterKey { symView: "。"; symView2: "“" }
        CharacterKey { symView: "，"; symView2: "”" }
        CharacterKey { symView: "；"; symView2: ";" }
        CharacterKey { symView: "："; symView2: ":" }
        CharacterKey { symView: "、"; symView2: "·" }
        CharacterKey { symView: "！"; symView2: "!" }
        CharacterKey { symView: "？"; symView2: "?" }

        BackspaceKey {}
    }


    Row {
        id: strokeRow
        property int strokeKeyWidth: (parent.width - backspace.width) / 6

        height: keyHeight
        visible: !keyboard.inSymView
        anchors.horizontalCenter: parent.horizontalCenter

        CharacterKey {
            width: strokeRow.strokeKeyWidth
            height: keyHeight
            caption: "\u4E00"
            captionShifted: "\u4E00"
        }
        CharacterKey {
            width: strokeRow.strokeKeyWidth
            height: keyHeight
            caption: "\u4E28"
            captionShifted: "\u4E28"
        }
        CharacterKey {
            width: strokeRow.strokeKeyWidth
            height: keyHeight
            caption: "\u4E3F"
            captionShifted: "\u4E3F"
        }
        CharacterKey {
            width: strokeRow.strokeKeyWidth
            height: keyHeight
            caption: "\u4E36"
            captionShifted: "\u4E36"
        }
        CharacterKey {
            width: strokeRow.strokeKeyWidth
            height: keyHeight
            caption: "\u4E5B"
            captionShifted: "\u4E5B"
        }
        CharacterKey {
            width: strokeRow.strokeKeyWidth
            height: keyHeight
            caption: "?"
            captionShifted: "?"
        }

        BackspaceKey {
            id: backspace
            height: keyHeight
        }
    }

    KeyboardRow {
        SymbolKey {
            caption: keyboard.inSymView ? "笔画" : "符号" // stroke/symbols
        }

        ChineseContextAwareCommaKey {}
        SpacebarKey {}
        ChineseContextAwarePeriodKey {}
        EnterKey {}
    }
}
