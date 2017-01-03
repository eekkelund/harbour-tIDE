/*
 * Copyright (C) 2012-2013 Jolla ltd and/or its subsidiary(-ies). All rights reserved.
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
import com.meego.maliitquick 1.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import harbour.tide.keyboard 1.0
import "../tide"

InputHandler {
    id: inputHandler
    Database {
        id: database
        Component.onCompleted:  database.initial("qml");
    }

    onPreeditChanged: {
        if (  preedit.length > 0 ) {
            applyWord()
        }
    }

    function acceptWord(word) {
        if ( preedit !== "" ) {
            commit(word)
            adjustWord(word)
            predictWord(word)
        } else {
            commit(word)
            adjustPredict(word)
            empty()

        }
    }

    function applyWord() {
        result = database.predict(preedit, 16)
        candidatesUpdated()
    }

    function applyMoreWord() {
        if ( result.length <= 16 ) {
            result = database.predict(preedit, 128)
            candidatesUpdated()
        }
    }

    function predictWord(word) {
        result = database.predict(word, 32)
        candidatesUpdated()
    }

    function adjustWord(word) {
        if ( settings.keys === 1 ) {
            database.adjust("word", word)
        }
    }

    function adjustPredict(word) {
        if ( settings.word === 1 ) {
            database.adjust("word", word)
        }
    }

    topItem: Component {
        CandidateRow {
            id: container
        }
    }

    verticalItem: Component {
        CandidateColumn {
            id: container
        }
    }

    CandidateDialog {
        id: candidateDialog
    }

    function handleKeyClick() {
        var handled = false
        keyboard.expandedPaste = false

        if ( pressedKey.key === Qt.Key_Space ) {
            empty()
            if ( preedit.length > 0 && result.length > 0 && settings.spacebar === true) {

                preedit = ""
                commit(result[0])
                adjustWord(result[0])
                predictWord(result[0])

                handled = true

            } else if ( preedit.length == 0 && result.length > 0 && settings.spacebar === 1 ) {
                commit(result[0])
                adjustPredict(result[0])
                empty()

            } else if ( preedit.length > 0 ) {
                commit(preedit+" ")

            } else {
                commit(" ")

            }
            handled = true
        } else if ( pressedKey.key === Qt.Key_Return ) {

            if ( preedit.length > 0 ) {
                commit(preedit)
            } else {
                empty()
                MInputMethodQuick.sendKey(Qt.Key_Return)
            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Tab ) {

            empty()
            commit(preedit)
            MInputMethodQuick.sendKey(Qt.Key_Tab, 0, "\t", Maliit.KeyClick)
            handled = true

        } else if ( pressedKey.key === Qt.Key_Backspace ) {


            if ( preedit.length > 0 ) {

                preedit = preedit.slice(0, preedit.length-1)
                MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)
                if ( preedit.length > 0 ) {
                    applyWord(preedit)
                } else {

                    empty()
                }

            } else if ( result.length > 0 ) {

                empty()
                MInputMethodQuick.sendKey(Qt.Key_Backspace)

            } else {
                MInputMethodQuick.sendKey(Qt.Key_Backspace)

            }

            handled = true

        } else if ( pressedKey.keyType === KeyType.FunctionKey && pressedKey.keyType === KeyType.SymbolKey ) {

            reset()
            empty()

            handled = true


        } else if ( pressedKey.text.match(/[abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ]/) !== null || ( pressedKey.text === "?" && preedit.length === 0 )) {

            if ( preedit.length >= 0 ) {

                preedit = preedit + pressedKey.text
                MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)

            }  else {
                reset()
                MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)


            }
            if (keyboard.shiftState !== ShiftState.LockedShift) {
                keyboard.shiftState = ShiftState.NoShift
            }
            handled = true

        }else if ( pressedKey.key === Qt.Key_Clear ) {

            reset()
            empty()

            handled = true

        } else if ( pressedKey.text === "1/2" || pressedKey.text === "2/2" ) {
            handled = true

        } else {
            MInputMethodQuick.sendCommit(preedit)
            commit(pressedKey.text)
            handled = true
        }

        return handled
    }

    function accept(index) {
        console.log("attempting to accept", index)
    }


    function reset() {
        preedit = ""
        MInputMethodQuick.sendPreedit("", Maliit.PreeditDefault)
    }

    function commit(text) {
        MInputMethodQuick.sendCommit(text)
        reset()
    }

    function empty() {
        result = []
    }

}
