import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.hwr 1.0
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0
import harbour.dolphin.keyboard 1.0




Item {
    id: root
    height: keyboard.layout.keyHeight * 3
    width: parent.width
    parent: keyboard
    anchors.top: parent.top
    z: 32

    HwrCanvas {
        id: hwrCanvas
        property bool trackingSymbol
        anchors.fill: parent
        lineWidth: geometry.hwrLineWidth
        threshold: geometry.hwrSampleThresholdSquared
        mask: !keyboard.portraitMode ? root : null
        color: Theme.highlightColor
        visible: !keyboard.inSymView


        onArcStarted: {
            console.warn("onArcStarted: ", x, y)
            fadeTimer.stop()
            if (fadeAnimation.running) {
                fadeAnimation.stop()
                clear()
                trackingSymbol = false
            }
            opacity = 1.0

            if (!trackingSymbol) {
                HwrModel.beginArcAddition()
                trackingSymbol = true
            }

            HwrModel.beginArc(x, y)
        }


        onArcPointAdded: {
            HwrModel.addPoint(x, y)
             keyAt(x, y)
        }

        onArcFinished: {
            console.warn("onArcFinished", x, y)
            fadeTimer.start()
            HwrModel.commitArc()

            console.warn("preedit", preedit)

            handleKeyClick()

        }

        onArcCanceled: {
            console.warn("onArcCanceled")
            fadeTimer.start()

        }

        SequentialAnimation {
            id: fadeAnimation

            NumberAnimation {
                target: hwrCanvas
                property: "opacity"
                to: 0
                duration: 150
            }

            ScriptAction {
                script: hwrCanvas.clear()
            }
        }

        Timer {
            id: fadeTimer
            interval: 320
            onTriggered: {
                keyboard.lastPressedKey = null
                hwrCanvas.trackingSymbol = false
                HwrModel.endArcAddition()
                fadeAnimation.start()
            }
        }
    }


    function keyAt(x, y) {
        if (keyboard.layout === null)
            return null

        var item = keyboard.layout

        x -= keyboard.layout.x
        y -= keyboard.layout.y

        while ( ( item = item.childAt(x, y) ) !== null )  {

            console.warn("item.keyType", item.keyType)

            if ( item.keyType === KeyType.CharacterKey && item.enabled === true && item !== keyboard.lastPressedKey ) {
                keyboard.lastPressedKey = item

                //commit(item.caption)
                preedit += item.caption
                console.warn("preedit", preedit)
                return item
            }

            // Cheaper mapToItem, assuming we're not using anything fancy.
            x -= item.x
            y -= item.y
        }

        return null
    }


}
