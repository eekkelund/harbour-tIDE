// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import com.meego.maliitquick 1.0

QtObject {
    property string characters
    property int index: -1

    property Timer timer: Timer {
        interval: 1000
        onTriggered: commit()
    }

    function commit() {
        if (index < characters.length) {
            MInputMethodQuick.sendCommit(characters.charAt(index))
        } else {
            console.log("Warning: multitap commit triggered with invalid cycle set")
        }

        timer.stop()
        index = -1
        characters = ""
    }

    function flush() {
        if (timer.running) {
            commit()
        }
    }

    function reset() {
        timer.stop()
        index = -1
        characters = ""
    }

    function apply(candidates) {
        if (candidates === "") {
            console.log("Warning: multitap called with empty cycle set")
        }

        if (candidates !== characters) {
            flush()
        }

        characters = candidates
        index++
        if (index >= characters.length) {
            index = 0
        }

        MInputMethodQuick.sendPreedit(characters.charAt(index))
        timer.restart()
    }
}
