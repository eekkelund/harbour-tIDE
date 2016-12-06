var array = new Array

function findById(id) {
    for (var i = 0; i < array.length; i++) {
        var point = array[i]
        if (point.pointId === id) {
            return point
        }
    }

    return null
}

function findByKeyId(keyId) {
    for (var i = 0; i < array.length; i++) {
        var point = array[i]
        if (point.pressedKey && point.pressedKey.key === keyId) {
            return point
        }
    }

    return null
}

function findByKeyType(keyType) {
    for (var i = 0; i < array.length; i++) {
        var point = array[i]
        if (point.pressedKey && point.pressedKey.keyType === keyType) {
            return point
        }
    }

    return null
}

function remove(point) {
    for (var i = 0; i < array.length; i++) {
        var item = array[i]
        if (item === point) {
            array.splice(i, 1)
            break
        }
    }
}

function addPoint(touchEvent) {
    var point = new Object
    point.pointId = touchEvent.pointId
    point.x = touchEvent.x
    point.y = touchEvent.y
    point.startX = touchEvent.startX
    point.startY = touchEvent.startY
    point.pressedKey = null
    point.initialKey = null

    array.push(point)
    return point
}
