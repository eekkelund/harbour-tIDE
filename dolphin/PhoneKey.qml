// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0
import QtMultimedia 5.0

KeyBase {
    id: aCharKey

    property alias secondaryLabel: secondaryLabel.text
    property bool separator: true
    property bool landscape

    keyType: KeyType.CharacterKey
    text: secondaryLabel.text
    showPopper: false
    Item {
        width: parent.width
        height: childrenRect.height
        anchors.centerIn: parent

        Text {
            id: mainLabel
            width: parent.width
            anchors.top: parent.top
            anchors.topMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
            lineHeight: 0.8
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: Theme.fontFamily
            font.pixelSize: keyboard.inSymView? Theme.fontSizeLarge * settings.scale: Theme.fontSizeTiny * settings.scale
            color: pressed ? Theme.highlightColor : Theme.primaryColor
            text: caption
            opacity: keyboard.inSymView? 0.8: 0.4
        }

        Text {
            id: secondaryLabel
            width: secondaryLabel.text.length === 4? ( keyboard.inSymView? parent.width / 3: parent.width / 2 ): parent.width
            wrapMode: Text.WrapAnywhere
            anchors.top: mainLabel.bottom
            anchors.topMargin: 4
            anchors.horizontalCenter: parent.horizontalCenter
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.family: Theme.fontFamily
            lineHeight: 0.64
            font.pixelSize: keyboard.inSymView? Theme.fontSizeTiny * settings.scale: ( secondaryLabel.text.length ===4? Theme.fontSizeMedium * settings.scale: Theme.fontSizeMedium * settings.scale )
            color: pressed ? Theme.highlightColor : Theme.primaryColor
            opacity: keyboard.inSymView? 0.4: 0.8
        }
    }

    Image {
        source: "graphic-keyboard-highlight-top.png"
        anchors.right: parent.right
        visible: separator
    }

    Rectangle {
        anchors.fill: parent
        z: -1
        color: Theme.highlightBackgroundColor
        opacity: 0.5
        visible: pressed
    }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        //propagateComposedEvents: keyboard.inputHandler === xt9Handler? true: false
        //visible: keyboard.inputHandler === xt9Handler? true: false
        propagateComposedEvents: true
        visible: true

        property int angle: 0
        property int distance: 0
        property bool autoRepeat: false
        property point start: Qt.point(0, 0);
        property int threshold: 16 * (height * 2 > width ? 2 : 1 )

        property bool swipeT: false
        property bool swipeB: false
        property bool swipeL: false
        property bool swipeR: false


        onPressed: {
            effectP.play()
            start = Qt.point(mouse.x, mouse.y)
            angle = 0
            distance = 0
            var pos = mapToItem(layout, mouse.x, mouse.y)
            mouse.accepted = true
        }

        SoundEffect {
            id: effectP
            source: "/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav"
        }


        SoundEffect {
            id: effectR
            source: "/usr/share/sounds/jolla-ambient/stereo/keyboard_option.wav"
        }

        onClicked: {


            buttonPressEffect.play()


            if ( keyboard.inSymView === true ) {
                //SYMBOL MODE
                MInputMethodQuick.sendCommit(caption)

                //ENGLISH MODE
            } else if ( keyboard.inputHandler === xt9Handler ) {
                MInputMethodQuick.sendCommit(secondaryLabel.text.charAt(1))
                //PINYIN MODE
            } else if ( secondaryLabel.text === "分詞" ) {
                keyboard.inputHandler.handleSW()

            } else {
                keyboard.inputHandler.handleT9(caption)
            }
        }

        onReleased: {
            buttonPressEffect.play()
            effectR.play()
            var pos = mapToItem(layout, mouse.x, mouse.y)
            mouse.accepted = true

            //9
            if ( swipeT  === true ) {
                if ( keyboard.inSymView === true ) {
                    MInputMethodQuick.sendCommit(secondaryLabel.text.charAt(1))
                } else {
                    MInputMethodQuick.sendCommit(caption)
                }

                swipeT = false
            }

            //y
            if ( swipeR === true ) {
                if ( keyboard.inSymView === true || keyboard.inputHandler === xt9Handler ) {
                     //SYMBOL MODE && ENGLISH MODE

                    MInputMethodQuick.sendCommit(secondaryLabel.text.charAt(2))

                } else {
                    keyboard.inputHandler.handlePY(secondaryLabel.text.charAt(2))
                }

                swipeR = false
            }

            //z
            if ( swipeB === true ) {

                if ( keyboard.inSymView === true || keyboard.inputHandler === xt9Handler ) {
                     //SYMBOL MODE && ENGLISH MODE

                    MInputMethodQuick.sendCommit(secondaryLabel.text.charAt(3))

                } else {
                    keyboard.inputHandler.handlePY(secondaryLabel.text.charAt(3))
                }
                    swipeB = false
            }
            //z
            if ( swipeL  === true ) {

                if ( keyboard.inSymView === true || keyboard.inputHandler === xt9Handler ) {
                     //SYMBOL MODE && ENGLISH MODE

                    MInputMethodQuick.sendCommit(secondaryLabel.text.charAt(0))

                } else {
                    keyboard.inputHandler.handlePY(secondaryLabel.text.charAt(0))
                }
                swipeL = false
            }



        }

        onPositionChanged: {

            angle = Math.atan2(mouse.y - start.y, mouse.x - start.x) * 360 / Math.PI / 2 + 180
            var d = Math.sqrt(Math.pow(mouse.x - start.x, 2) + Math.pow(mouse.y - start.y, 2))
            distance = Math.round(d / threshold)
            var pos = mapToItem(layout, mouse.x, mouse.y)

            if ( secondaryLabel.text.length === 4 ) {
                if ( distance > 2 && angle >= 45 && angle <= 134 ){
                    swipeT = true
                    secondaryLabel.text.caption

                } else if ( distance > 2 && angle >= 135 && angle <= 214 ){
                    swipeR = true
                    secondaryLabel.text.charAt(2)
                } else if ( distance > 2 && angle >= 215 && angle <= 304 ){
                    swipeB = true
                    popper.label = secondaryLabel.text.charAt(3)
                } else if ( distance > 2 ) {
                    swipeL = true
                    popper.label = secondaryLabel.text.charAt(0)
                }

            } else if ( secondaryLabel.text.length === 3 ) {
                if ( distance > 2 && angle >= 30 && angle <= 149 ){
                    swipeT = true
                    popper.label = caption
                } else if ( distance > 2 && angle >= 150 && angle <=269 ){
                    swipeR = true
                    popper.label = secondaryLabel.text.charAt(2)
                } else if ( distance > 2 ) {
                    swipeL = true
                    popper.label = secondaryLabel.text.charAt(0)
                }
            }
        }

        //BACKGROUND
        Rectangle {
            color: parent.pressed ? Theme.highlightBackgroundColor : "#00000000"
            anchors.fill: parent
            opacity: 0.4
        }

        Rectangle {

            property string label: ""

            id: popper
            visible: ( parent.swipeT === true || parent.swipeR === true || parent.swipeB === true || parent.swipeL === true )? true: false
            anchors.bottom: parent.top
            color: Qt.darker(Theme.highlightBackgroundColor, 1.2)
            width: parent.width
            height: parent.height
            radius: geometry.popperRadius

            Label {
                anchors.centerIn: parent
                text: parent.label
            }
        }
    }


}

