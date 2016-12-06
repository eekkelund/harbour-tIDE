// Copyright (C) 2013 Jolla Ltd.
// Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>

import QtQuick 2.2

Loader {
    property int index: -1
    property int pendingIndex: -1

    width: parent.width
    source: index >= 0 ?  "/usr/share/maliit/plugins/com/jolla/layouts/" + canvas.layoutModel.get(index).layout : ""
    onLoaded: {
        item.languageCode = canvas.layoutModel.count > 1 ? canvas.layoutModel.get(index).languageCode : ""
        if (pendingIndex >= 0) {
            index = pendingIndex
            pendingIndex = -1
        } else {
            layoutRow.startTransition()
        }
    }
    onVisibleChanged: if (item) item.visible = visible
    asynchronous: true
}
