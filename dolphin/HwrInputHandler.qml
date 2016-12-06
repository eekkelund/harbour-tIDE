import QtQuick 2.2
import com.meego.maliitquick 1.0
import Sailfish.Silica 1.0
import com.jolla.hwr 1.0
import com.jolla.keyboard 1.0

InputHandler {
    id: hwrHandler

    property string inputMode: layoutRow.layout ? layoutRow.layout.inputMode : ""
    property string preedit: HwrModel.primaryCandidate

    onInputModeChanged: HwrModel.inputMode = inputMode

    onPreeditChanged: {
        if (active) {
            MInputMethodQuick.sendPreedit(preedit)
        }
    }

    Component {
        id: pasteComponent
        PasteButton {
            onClicked: {
                if (preedit !== "") {
                     MInputMethodQuick.sendCommit(preedit)
                }
                MInputMethodQuick.sendCommit(Clipboard.text)
                HwrModel.clear()
                keyboard.expandedPaste = false
            }
        }
    }

    topItem: Component {
        TopItem {
            id: topItem
            visible: canvas.portraitLayout
            height: visible ? Theme.itemSizeSmall : 0

            Rectangle {
                height: parent.height
                width: parent.width
                color: Theme.rgba(Theme.highlightBackgroundColor, .05)

                ListView {
                    id: listView
                    model: HwrModel
                    orientation: ListView.Horizontal
                    anchors.fill: parent
                    header: pasteComponent
                    boundsBehavior: !keyboard.expandedPaste && Clipboard.hasText ? Flickable.DragOverBounds : Flickable.StopAtBounds

                    onDraggingChanged: {
                        if (!dragging && !keyboard.expandedPaste && contentX < -(headerItem.width + Theme.paddingLarge)) {
                            keyboard.expandedPaste = true
                            positionViewAtBeginning()
                        }
                    }

                    delegate: BackgroundItem {
                        onClicked: hwrHandler.applyCandidate(model.text)
                        width: candidateText.width + Theme.paddingLarge * 2
                        height: topItem.height

                        Text {
                            id: candidateText
                            anchors.centerIn: parent
                            color: highlighted ? Theme.highlightColor : Theme.primaryColor
                            font { pixelSize: Theme.fontSizeSmall; family: Theme.fontFamily }
                            text: model.text
                        }
                    }
                }

                Connections {
                    target: Clipboard
                    onTextChanged: {
                        if (Clipboard.hasText) {
                            // need to have updated width before repositioning view
                            positionerTimer.restart()
                        }
                    }
                }

                Connections {
                    target: HwrModel
                    onModelReset: keyboard.expandedPaste = false
                    onCharacterStarted: {
                        if (hwrHandler.preedit !== "") {
                            MInputMethodQuick.sendCommit(hwrHandler.preedit)
                        }
                    }
                }

                Timer {
                    id: positionerTimer
                    interval: 10
                    onTriggered: listView.positionViewAtBeginning()
                }
            }
        }
    }

    onActiveChanged: {
        if (!active && preedit !== "") {
            MInputMethodQuick.sendCommit(preedit)
            HwrModel.clear()
        }
    }

    function handleKeyClick() {
        keyboard.expandedPaste = false
        if (preedit !== "") {
            if (pressedKey.key === Qt.Key_Space || pressedKey.key === Qt.Key_Return) {
                MInputMethodQuick.sendCommit(preedit)
                HwrModel.clear()
                return true
            } else if (pressedKey.key === Qt.Key_Backspace) {
                MInputMethodQuick.sendPreedit("")
                HwrModel.clear()
                return true
            }
        }
        return false
    }

    function applyCandidate(text) {
        MInputMethodQuick.sendCommit(text)
        HwrModel.clear()
        if (canvas.phraseEngine) {
            HwrModel.setPhraseCandidates(canvas.phraseEngine.phraseCandidates(text))
        }
    }
}
