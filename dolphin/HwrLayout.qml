// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.hwr 1.0
import com.jolla.keyboard 1.0
import "."

KeyboardLayout {
    id: hwrLayout
    type: "hwr"

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
        visible: keyboard.inSymView && !hwrLayout.portraitMode

        ShiftKey {}

        CharacterKey { symView: "。"; symView2: "“" }
        CharacterKey { symView: "，"; symView2: "”" }
        CharacterKey { symView: "；"; symView2: ";" }
        CharacterKey { symView: "："; symView2: ":" }
        CharacterKey { symView: "、"; symView2: "·" }
        CharacterKey { symView: "！"; symView2: "!" }
        CharacterKey { symView: "？"; symView2: "?" }

        BackspaceKey {}
    }

    KeyboardRow {
        visible: keyboard.inSymView && hwrLayout.portraitMode

        ShiftKey {}

        CharacterKey { symView: "。"; symView2: "“" }
        CharacterKey { symView: "，"; symView2: "”" }
        CharacterKey { symView: "；"; symView2: ";" }
        CharacterKey { symView: "："; symView2: ":" }
        CharacterKey { symView: "、"; symView2: "·" }
        CharacterKey { symView: "！"; symView2: "!" }
        CharacterKey { symView: "？"; symView2: "?" }
    }

    Item {
        height: !keyboard.inSymView ? geometry.hwrCanvasHeight
                                    : hwrLayout.portraitMode ? 0 : hwrLayout.keyHeight
        width: parent.width

        Rectangle {
            id: shadeRect
            visible: !hwrLayout.portraitMode && !keyboard.inSymView
            height: geometry.hwrCanvasHeight
            width: hwrLayout.portraitMode ? parent.width : parent.width * .75
            x: hwrLayout.portraitMode ? 0 : parent.width * .25
            gradient: Gradient {
                GradientStop { position: 0; color: Theme.rgba(Theme.highlightBackgroundColor, .10) }
                GradientStop { position: 1; color: Theme.rgba(Theme.highlightBackgroundColor, .0) }
            }
        }

        HwrCanvas {
            id: hwrCanvas

            property bool trackingSymbol

            height: geometry.hwrCanvasHeight
            width: hwrLayout.portraitMode ? parent.width : parent.width * .75
            x: hwrLayout.portraitMode ? 0 : parent.width * .25
            lineWidth: geometry.hwrLineWidth
            threshold: geometry.hwrSampleThresholdSquared
            //mask: !hwrLayout.portraitMode ? maskItem : null
            color: Theme.highlightColor
            visible: !keyboard.inSymView

            onArcStarted: {
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
            onArcPointAdded: HwrModel.addPoint(x, y)
            onArcFinished: {
                fadeTimer.start()
                HwrModel.commitArc()
                gridView.contentY = 0
            }
            onArcCanceled: fadeTimer.start()

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
                interval: 800
                onTriggered: {
                    hwrCanvas.trackingSymbol = false
                    HwrModel.endArcAddition()
                    fadeAnimation.start()
                }
            }
        }

        Connections {
            target: HwrModel
            onCleared: {
                if (fadeTimer.running) {
                    hwrCanvas.trackingSymbol = false
                    fadeTimer.stop()
                    fadeAnimation.start()
                }
            }
        }

        IconButton {
            visible: hwrCanvas.visible
            anchors {
                right: parent.right
                top: parent.top
                topMargin: Theme.paddingSmall
            }
            opacity: .6
            icon.source: "image://theme/icon-close-vkb"
            onClicked: MInputMethodQuick.userHide()
        }

        Item {
            id: maskItem
            anchors.fill: parent
            visible: !hwrLayout.portraitMode

            Row {
                id: leftLandscapeRow
                height: geometry.keyHeightLandscape
                anchors.bottom: parent.bottom

                SymbolKey {
                    height: parent.height
                    caption: keyboard.inSymView ? "手写" : "符号" // symbols/hwr
                    width: geometry.functionKeyWidthPortrait
                }
                CharacterKey {
                    height: parent.height
                    caption: ","
                    captionShifted: ","
                    width: gridView.width / 3
                    separator: SeparatorState.HiddenSeparator
                }
                SpacebarKey {
                    height: parent.height
                    width: geometry.functionKeyWidthPortrait
                }
            }

            Row {
                id: rightLandscapeRow
                height: geometry.keyHeightLandscape
                anchors {
                    bottom: parent.bottom
                    right: parent.right
                }

                SpacebarKey {
                    languageLabel: ""
                    height: parent.height
                    width: geometry.functionKeyWidthPortrait
                }

                CharacterKey {
                    height: parent.height
                    caption: "."
                    captionShifted: "."
                    width: gridView.width / 3
                    separator: SeparatorState.HiddenSeparator
                }

                EnterKey {
                    height: parent.height
                    width: geometry.functionKeyWidthPortrait
                }
            }

            BackspaceKey {
                id: landscapeBackspace
                visible: !keyboard.inSymView
                anchors {
                    bottom: rightLandscapeRow.top
                    right: parent.right
                }
                height: geometry.keyHeightLandscape
            }

            SilicaFlickable {
                id: gridView
                visible: !keyboard.inSymView
                anchors {
                    top: parent.top
                    topMargin: Theme.paddingMedium
                    left: parent.left
                    leftMargin: Theme.paddingSmall
                    bottom: leftLandscapeRow.top
                }
                width: hwrLayout.width * .25 - Theme.paddingSmall
                clip: true
                contentHeight: flow.height
                boundsBehavior: Flickable.StopAtBounds

                Flow {
                    id: flow
                    width: parent.width

                    Repeater {
                        model: HwrModel
                        delegate: BackgroundItem {
                            onClicked: {
                                gridView.contentY = 0
                                keyboard.inputHandler.applyCandidate(model.text)
                            }
                            width: Math.min(Math.max(gridView.width / 3, candidateText.paintedWidth), gridView.width)
                            height: Theme.itemSizeSmall

                            Text {
                                id: candidateText
                                anchors.centerIn: parent
                                color: highlighted ? Theme.highlightColor : Theme.primaryColor
                                font { pixelSize: Theme.fontSizeSmall; family: Theme.fontFamily }
                                text: model.text
                            }
                        }
                    }
                }
            }

            PasteButton {
                previewWidthLimit: geometry.hwrPastePreviewWidth
                visible: !keyboard.inSymView && Clipboard.hasText
                popupAnchor: 1 // = right
                anchors {
                    right: parent.right
                    bottom: landscapeBackspace.top
                }
                height: Theme.itemSizeSmall

                onClicked: {
                    if (keyboard.inputHandler.preedit !== "") {
                        MInputMethodQuick.sendCommit(keyboard.inputHandler.preedit)
                    }
                    MInputMethodQuick.sendCommit(Clipboard.text)
                    HwrModel.clear()
                    keyboard.expandedPaste = false
                }
            }
        }
    }

    KeyboardRow {
        visible: hwrLayout.portraitMode

        SymbolKey {
            caption: inputMode === "traditional" ? keyboard.inSymView ? "手寫" : "符號" // hwr/symbols
                                                 : keyboard.inSymView ? "手写" : "符号" // hwr/symbols
        }

        SpacebarKey {}

        BackspaceKey {}

        EnterKey {}
    }
}
