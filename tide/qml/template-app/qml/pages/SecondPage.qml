import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    Column {
        id:column
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: hdr.height+label.height
        PageHeader {
            id:hdr
            title: qsTr("Page 2")
        }
        Label {
            id:label
            anchors.horizontalCenter: parent.horizontalCenter
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            text: "<style>
              a {color: " +Theme.highlightBackgroundColor+";\}
              </style>Check my <a href='https://github.com/eekkelund'>GitHub</a>"
            onLinkActivated: {
                Qt.openUrlExternally(link)
                console.log("Link opened")
            }
        }
    }
    Row {
        anchors {
            top: column.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        SilicaListView {
            id: list1
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width:parent.width/2
            clip: true
            model: 15
            delegate: ListItem {
                id: item
                Label {
                    x: Theme.paddingMedium
                    text:qsTr("Index") + " " +index
                    anchors.verticalCenter: parent.verticalCenter
                }
                onClicked: console.log("Clicked index: " + index)
            }
            VerticalScrollDecorator {}

        }
        SilicaListView {
            id: list2
            anchors {
                top: parent.top
                bottom: parent.bottom
            }
            width:parent.width/2
            clip: true
            model: 15
            delegate: ListItem {
                id: item2
                Label {
                    x: Theme.paddingMedium
                    text:qsTr("Index") + " " +index
                    anchors.verticalCenter: parent.verticalCenter
                }
                onClicked: console.log("Clicked index2: " + index)
            }
            VerticalScrollDecorator {}
        }
    }
}





