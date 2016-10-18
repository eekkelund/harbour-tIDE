import QtQuick 2.0
import com.meego.maliitquick 1.0
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import harbour.sailorcreator.keyboard 1.0
import "../sailorcreator"

InputHandler {
    id: inputHandler
    Database {
        id: database
        name: "develop"
        Component.onCompleted: database.initial("develop");
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
        //result = database.develop(preedit, 16)
        result = database.predict(preedit, 16)
        candidatesUpdated()
    }

    function applyMoreWord() {
        if ( result.length <= 16 ) {
            //result = database.develop(preedit, 128)
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

    /*EmojiDialog {
        id: emojiDialog
    }*/

    CandidateDialog {
        id: candidateDialog
    }

    function handleKeyClick() {
        var handled = false
        keyboard.expandedPaste = false

        if ( pressedKey.key === Qt.Key_Space ) {

            if ( preedit.length > 0 && result.length > 0 && /*config.spacebar === 1*/ settings.spacebar === true) {

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
                MInputMethodQuick.sendKey(Qt.Key_Return)
            }

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

        } else if ( pressedKey.text === "通" ) {

            if ( preedit.length > 0  ) {
                preedit = preedit + "?"
                MInputMethodQuick.sendPreedit(preedit, Maliit.PreeditDefault)

            }

            handled = true

        } else if ( pressedKey.key === Qt.Key_Clear ) {

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
