// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2

Item {

    //Doplhin Keyboard
    property real ratio: 1

    property bool followRowHeight: true
    property int splitIndex: -1

    // calculates maximum width for a "basic" button
    function maximumBasicButtonWidth(shareableWidth) {
        if (avoidanceWidth > 0) {
            var split = splitIndex > 0 ? splitIndex : Math.floor(children.length / 2)
            shareableWidth = (shareableWidth - avoidanceWidth) / 2
            var first = _maximumButtonWidthPart(shareableWidth, 0, split)
            var second = _maximumButtonWidthPart(shareableWidth, split, children.length)
            return Math.min(first, second)
        } else {
            return _maximumButtonWidthPart(shareableWidth, 0, children.length)
        }
    }

    function _maximumButtonWidthPart(shareableWidth, startIndex, endIndex) {
        var basicButtonCount = 0
        var originalWidth = shareableWidth
        var i

        for (i = startIndex; i < endIndex; ++i) {
            var child = children[i]
            if (!child.active) {
                continue
            }

            if (_isBasicButton(child)) {
                basicButtonCount++
            } else {
                shareableWidth -= child.implicitWidth
            }
        }

        return basicButtonCount !== 0 ? shareableWidth / basicButtonCount
                                      : originalWidth
    }

    function relayout(basicButtonWidth) {
        if (avoidanceWidth > 1) {
            // get middle and layout both sides separately
            var shareableWidth = width - avoidanceWidth
            var split = splitIndex > 0 ? splitIndex : Math.floor(children.length / 2)
            _relayoutPart(basicButtonWidth, 0, split, 0, shareableWidth / 2)
            _relayoutPart(basicButtonWidth, split, children.length, width / 2 + avoidanceWidth / 2, shareableWidth / 2)

        } else {
            _relayoutPart(basicButtonWidth, 0, children.length, 0, width)
        }
    }

    function _relayoutPart(basicButtonWidth, startIndex, endIndex, startX, shareableWidth) {
        var expandingKeys = []
        var child
        var i

        for (i = startIndex; i < endIndex; ++i) {
            child = children[i]
            if (!child.active) {
                child.visible = false
                continue
            }

            child.visible = true
            child.height = parent.keyHeight * ratio

            if (_isExpandingKey(child)) {
                expandingKeys.push(child)
            } else if (_isBasicButton(child)) {
                child.width = basicButtonWidth
                child.leftPadding = 0
                child.rightPadding = 0
                child.implicitSeparator = true
                shareableWidth -= basicButtonWidth
            } else {
                child.width = undefined
                shareableWidth -= child.implicitWidth
            }
        }

        if (expandingKeys.length > 0) {
            // allocate extra space to expanding keys
            for (i = 0; i < expandingKeys.length; ++i) {
                expandingKeys[i].width = shareableWidth / expandingKeys.length
            }
        } else {
            var extra = Math.max(shareableWidth / 2, 0)

            // allocate extra space to first and last basic key (assuming separate keys)
            for (i = startIndex; i < endIndex; ++i) {
                child = children[i]

                if (child.active && _isBasicButton(child)) {
                    child.width = basicButtonWidth + extra
                    child.leftPadding = extra
                    break
                }
            }

            for (i = endIndex - 1; i >= startIndex; --i) {
                child = children[i]
                if (child.active && _isBasicButton(child)) {
                    child.implicitSeparator = false
                    child.width = basicButtonWidth + extra
                    child.rightPadding = extra
                    break
                }
            }
        }

        // final pass, set X coordinates for all children
        var x = startX
        for (i = startIndex; i < endIndex; ++i) {
            child = children[i]
            if (!child.active) {
                continue
            }

            child.x = x
            x += child.width
        }
    }

    function _isBasicButton(item) {
        // Hack: relying on property
        return item.hasOwnProperty("symView") && !item.fixedWidth
    }

    function _isExpandingKey(item) {
        return item.hasOwnProperty("expandingKey") && item.expandingKey
    }
}
