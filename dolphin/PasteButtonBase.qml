// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {
    id: pasteContainer

    property int popupAnchor // 0 -> left, 1 -> right, 2 -> center
    property alias popupParent: popup.parent

    height: parent ? parent.height : 0
    width: Clipboard.hasText ? (keyboard.expandedPaste ? pasteRow.width + 2*Theme.paddingMedium
                                                       : pasteIcon.width + Theme.paddingMedium)
                             : 0

    preventStealing: popup.visible
    highlighted: down || popup.visible

    onPressAndHold: popup.visible = true
    onReleased: {
        if (popup.visible && popup.containsMouse)
            Clipboard.text = ""
        popup.visible = false
    }
    onCanceled: popup.visible = false
    onPositionChanged: {
        if (!popup.visible) {
            return
        }

        var pos = mapToItem(popup, mouse.x, mouse.y)
        var wasSelected = popup.containsMouse
        popup.containsMouse = popup.contains(Qt.point(pos.x, pos.y - geometry.clearPasteTouchDelta))
        if (wasSelected != popup.containsMouse) {
            SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
            buttonPressEffect.play()
        }
    }

    Rectangle {
        id: popup

        property bool containsMouse

        visible: false
        width: clearLabel.width + geometry.clearPasteMargin
        height: clearLabel.height + geometry.clearPasteMargin
        anchors.right: pasteContainer.popupAnchor == 1 ? parent.right : undefined
        anchors.horizontalCenter: pasteContainer.popupAnchor == 2 ? parent.horizontalCenter : undefined
        anchors.bottom: parent.top
        radius: geometry.popperRadius
        color: Qt.darker(Theme.highlightBackgroundColor, 1.3)

        onVisibleChanged: containsMouse = false

        Label {
            id: clearLabel
            anchors.centerIn: parent
            color: parent.containsMouse ? Theme.primaryColor : Theme.highlightColor
            //% "Clear clipboard"
            text: qsTrId("text_input-la-clear_clipboard")
        }
    }
}
