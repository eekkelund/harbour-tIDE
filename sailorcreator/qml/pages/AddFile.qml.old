import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3


Page {
    id: page
    property string path
    property string ext: ".qml"
    //allowedOrientations: Orientation.Landscape
    //Column {
    //  id: column
    // anchors.fill: parent

    SilicaListView {
        id: sList
        anchors.fill: parent
        header: PageHeader {
            id:hdr
            title: qsTr("Add a new file")
        }
        model: VisualItemModel {
            Row {
                TextField {
                    id: fileName
                    //anchors.left: parent.left
                    //anchors.right: cBox.left
                    placeholderText: qsTr("Name of the file")
                    width: page.width/2
                    validator: RegExpValidator { regExp: /.{1,}/ }
                }
                ComboBox {
                    id:cBox
                    width: page.width / 2
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
                }
            }



            Button {
                id:add
                anchors.horizontalCenter: parent.horizontalCenter
                text:qsTr("Add file")
                onPressed: {
                    if (fileName.text !== "") {
                        var fName = fileName.text;
                        py.call('addFile.createFile', [fName,ext,path], function() {
                        });
                        filePath = (path +"/"+ fName + ext)
                        pageStack.replace(Qt.resolvedUrl("Editor.qml"))


                        //console.log(projectQmlPath);
                        //pageStack.replace(Qt.resolvedUrl("CreatorHome.qml")/*, {fullpath: projectPath +projectN.text+"/qml/"+projectN.text+".qml"}, {project: projectN.text}*/);
                    }
                }
            }
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

    //}
}

