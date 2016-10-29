import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3


Page {
    property int count
    id: page
    SilicaFlickable {
        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                text: qsTr("Show Second page")
                onClicked: pageStack.push(Qt.resolvedUrl("SecondPage.qml"))
            }
        }
        contentHeight: column.height
        Column {
            id: column
            width: page.width
            spacing: Theme.paddingLarge
            PageHeader {
                title: qsTr("Python example")
            }
            Button {
                id:button
                anchors.horizontalCenter: parent.horizontalCenter
                text:count
                onPressed: {
                    py.call("button.press",[count],function(result) {
                        console.log(qsTr("Sent: " +count+" Received: "+result))
                        count=result
                    });
                }
            }
        }
    }
    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('.'));
            importModule('button', function() {});

        }
    }
}


