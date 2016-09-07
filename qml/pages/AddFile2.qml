import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4


Dialog {
    id:dialog
    property string path
    property string ext: ".qml"
    Column {
        anchors.fill: parent
        DialogHeader {
            acceptText: qsTr("Add")
        }

        //model: VisualItemModel {
            Row {
                TextField {
                    id: fileName
                    //anchors.left: parent.left
                    //anchors.right: cBox.left
                    placeholderText: qsTr("Name of the file")
                    width: dialog.width/2
                    validator: RegExpValidator { regExp: /.{1,}/ }
                }
                ComboBox {
                    id:cBox
                    width: dialog.width / 2
                    //anchors.right: parent.right
                    //anchors.left: fileName.right
                    menu: ContextMenu {
                        MenuItem {
                            text: ".qml"
                            onClicked: ext = text
                        }
                        MenuItem {
                            text: ".js"
                            onClicked: ext = text
                        }
                        MenuItem {
                            text: ".py"
                            onClicked: ext = text
                        }
                        MenuItem {
                            text: ".txt"
                            onClicked: ext = text
                        }
                    }
                //}
            }
        }
    }
    canAccept: fileName.text !== "" ? true :false
    onDone: {
        if (fileName.text !== "") {
            var fName = fileName.text;
            py.call('addFile.createFile', [fName,ext,path], function() {
            });
            filePath = (path +"/"+ fName + ext)

            //pageStack.replace(Qt.resolvedUrl("Editor.qml"))

        }
    }

    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./python'));
            importModule('addFile', function() {});

        }
        onError: {
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }
        onReceived: console.log('Unhandled event: ' + data)
    }
}
