// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0

Item {
    id: popperCell
    width: geometry.accentPopperCellWidth
    height: geometry.popperHeight

    property bool active
    property alias character: textItem.text
    property alias textVisible: textItem.visible

    Text {
        id: textItem
        anchors.centerIn: parent
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        color: Theme.primaryColor
        opacity: popperCell.active ? 1 : .35
        font.family: Theme.fontFamily
        font.pixelSize: geometry.popperFontSize
    }
}
