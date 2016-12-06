// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

Rectangle {
    id: popup

    property int activeCell: -1
    property bool inInitialPosition
    property int pointId
    property alias opening: openAnimation.running
    property real bottomLine
    property int targetHeight

    y: bottomLine - height
    visible: false
    radius: geometry.popperRadius
    color: Qt.darker(Theme.highlightBackgroundColor, 1.3)
    clip: openAnimation.running

    Column {
        id: contentColumn
        width: parent.width
        anchors.verticalCenter: parent.verticalCenter
    }

    NumberAnimation on height {
        id: openAnimation
        duration: 100
        easing.type: Easing.OutQuad
        to: popup.targetHeight + Theme.paddingLarge
    }

    Component {
        id: listRow
        Row {
            x: parent ? (parent.width - width) * .5 : 0
            height: Theme.itemSizeSmall
        }
    }

    SequentialAnimation {
        id: fadeAnimation
        NumberAnimation {
            duration: 100
            to: 0
            target: popup
            property: "opacity"
        }
        ScriptAction {
            script: {
                visible = false
                contentColumn.children = []
            }
        }
    }

    function show(touchPoint) {
        fadeAnimation.stop()
        inInitialPosition = true
        pointId = touchPoint.pointId
        height = 0
        targetHeight = 0
        bottomLine = parent.mapFromItem(touchPoint.pressedKey, 0, 0).y - Theme.paddingLarge
        canvas.captureFullScreen()

        activeCell = canvas.activeIndex

        var maxAllowedWidth = Math.min(parent.width - Theme.paddingSmall * 2,
                                       geometry.languageSelectionPopupMaxWidth)
        var maxContentWidth = maxAllowedWidth - geometry.languageSelectionPopupContentMargins
        var cellComponent = Qt.createComponent("LanguageSelectionCell.qml");
        var row = null
        var maxRowWidth = 0
        var cells = new Array
        var itemsPerRow = new Array
        var itemsInRow = 0
        var rowWidth = 0

        // layout cells. We don't use Flow as the (possible) uneven row needs
        // to be topmost and rows need to be center aligned

        // first create cells and calculate how many cells
        // fit in a row. Start from the last cell and remember the cell count
        // for each row
        for (var i = canvas.layoutModel.count-1; i >= 0; --i) {
            if (!canvas.layoutModel.get(i).enabled) {
                continue
            }

            if (canvas.layoutModel.enabledCount === 2 && i !== canvas.activeIndex) {
                // In case there's two enabled languages, highlight the inactive one
                // to allow quick switching to that layout.
                activeCell = i
            }

            var cell = cellComponent.createObject(null,
                                                  {"index": i,
                                                   "text": canvas.layoutModel.get(i).name})
            cells.push(cell)

            if (rowWidth + cell.width > maxContentWidth) {
                if (rowWidth > maxRowWidth) {
                    maxRowWidth = rowWidth
                }
                itemsPerRow.push(itemsInRow)
                itemsInRow = 0
                rowWidth = 0
            }

            itemsInRow++
            rowWidth += cell.width
        }

        if (itemsInRow > 0) {
            // close last row
            if (rowWidth > maxRowWidth) {
                maxRowWidth = rowWidth
            }
            itemsPerRow.push(itemsInRow)
        }

        // then create rows and insert cells
        var cellHead = cells.length
        for (var j = itemsPerRow.length - 1; j >= 0; j--) {
            itemsInRow = itemsPerRow[j]
            cellHead -= itemsInRow

            row = listRow.createObject(contentColumn)
            targetHeight += row.height

            // the order of cells in a row needs to be swapped to
            // maintain alphabetical order
            for (var k = cellHead + itemsInRow - 1; k >= cellHead; --k) {
                cell = cells[k]
                cell.parent = row
                row.width += cell.width
            }
        }

        width = Math.min(maxAllowedWidth, maxRowWidth + geometry.languageSelectionPopupContentMargins)
        if (parent.width - width <= Theme.paddingLarge) {
            // if the width of the popup is "almost" same as width of the parent, center align
            x = (parent.width - width) * .5
        } else {
            // else center align around the press point
            var xPos = Math.max(touchPoint.x - width * .5, Theme.paddingSmall)
            x = Math.min(parent.width - width - Theme.paddingSmall, xPos)
        }

        opacity = 1
        visible = true
        openAnimation.start()
    }
    function hide() {
        if (opening) {
            openAnimation.stop()
            visible = false
            contentColumn.children = []
        } else if (visible) {
            fadeAnimation.start()
            canvas.updateIMArea()
        }
    }
    function handleMove(touchPoint) {
        if (touchPoint.pointId !== pointId)
            return

        if (inInitialPosition) {
            var deltaX = touchPoint.x-touchPoint.startX
            var deltaY = touchPoint.y-touchPoint.startY
            if (deltaX*deltaX + deltaY*deltaY <
                geometry.languageSelectionInitialDeltaSquared) {
                return
            }
        }

        inInitialPosition = false

        var oldActiveCell = activeCell

        var yInContent = parent.mapToItem(popup, touchPoint.x, touchPoint.y).y
        if (yInContent < 0 || yInContent > height) {
            activeCell = -1
        }

        var item = contentColumn
        do {
            if (item.hasOwnProperty("index")) {
                activeCell = item.index
                break
            }
            var pos = parent.mapToItem(item, touchPoint.x, touchPoint.y)
            pos.y -= geometry.languageSelectionTouchDelta
            item = item.childAt(pos.x, pos.y)
        } while (item);

        if (oldActiveCell !== activeCell && activeCell >= 0) {
            SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
            buttonPressEffect.play()
        }
    }
}
