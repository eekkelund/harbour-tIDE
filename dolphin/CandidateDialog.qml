import QtQuick 2.2
import Sailfish.Silica 1.0
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0


Rectangle {
    id: root
    visible: fetchMany
    parent: keyboard
    z: 2
    anchors.fill: parent
    anchors.topMargin:topItem.height
    color: Theme.rgba(Theme.highlightDimmerColor, 1)


    SilicaFlickable {
        height: parent.height
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: close.left
        contentHeight: flow.height
        flickableDirection: Flickable.VerticalFlick
        clip: true

        VerticalScrollDecorator {  }

        Flow {
            id: flow
            width: parent.width

            Repeater {
                id: repeater
                model: result

                delegate: Component {

                    DelegateV {
                        id: delegateV
                    }
                }
            }
        }
    }

    Close {
        id: close
        onClicked: {
            fetchMany = false
        }
    }

    MultiPointTouchArea {
        // prevent events leaking below
        anchors.fill: parent
        z: -1
    }
}
