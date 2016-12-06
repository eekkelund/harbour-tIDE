/****************************************************************************************
**
** Copyright (C) 2013 Jolla Ltd.
** Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>
** All rights reserved.
**
** You may use this file under the terms of BSD license as follows:
**
** Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are met:
**     * Redistributions of source code must retain the above copyright
**       notice, this list of conditions and the following disclaimer.
**     * Redistributions in binary form must reproduce the above copyright
**       notice, this list of conditions and the following disclaimer in the
**       documentation and/or other materials provided with the distribution.
**     * Neither the name of the Jolla Ltd nor the
**       names of its contributors may be used to endorse or promote products
**       derived from this software without specific prior written permission.
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
** ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
** WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
** DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE LIABLE FOR
** ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
** (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
** LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
** ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
** SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**
****************************************************************************************/

import QtQuick 2.2
import com.meego.maliitquick 1.0

InputHandler {
    property string preedit

    function handleKeyClick() {
        if ((pressedKey.text === " ") || (pressedKey.key === Qt.Key_Return) && preedit.length !== "") {
            MInputMethodQuick.sendCommit(preedit)
            preedit = ""

        } else if (pressedKey.text !== "" && MInputMethodQuick.predictionEnabled) {
            preedit = preedit + pressedKey.text
            MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)
            keyboard.isShifted = false
            return true

        } else if (pressedKey.key === Qt.Key_Backspace && preedit !== "") {
            preedit = preedit.substring(0, preedit.length - 1)
            MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)
            // need to manually check autocaps when preedit gets removed, real cursor position doesn't change
            if (preedit.length === 0)
                keyboard.applyAutocaps()
            else
                keyboard.isShifted = false
            return true
        }

        return false
    }

    function reset() {
        preedit = ""
    }
}
