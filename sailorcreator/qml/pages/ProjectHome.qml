import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3


Page {
    id: page
    property string confusingPath: projectPath+ "/"+projectName

    property string ext: ".qml"


    SilicaListView {
        id:fileList
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        VerticalScrollDecorator {}
        PullDownMenu {
            MenuItem {
                text: qsTr("Run the app")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AppOutput.qml"))
                    //py.call("startProject.start", [projectQmlPath],function(result) {});
                }
            }
            MenuItem {
                text: qsTr("Add file")
                onClicked: {
                    pageStack.push(dialog, {path:confusingPath})
                }
            }
        }

        header: Column {
            width: parent.width
            spacing: Theme.paddingMedium
            PageHeader  {
                width: parent.width
                title: projectName
            }
            Label {
                width: parent.width
                //anchors.topMargin: Theme.paddingMedium
                anchors.bottomMargin: Theme.paddingLarge
                x: Theme.paddingLarge
                text: qsTr("Select file to open")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
                //horizontalAlignment: Text.AlignRight
            }
        }

        model: ListModel{
            id: lmodel
            function loadNew(path) {
                clear()
                py.call('openFile.files', [path], function(result) {
                    for (var i=0; i<result.length; i++) {
                        lmodel.append(result[i]);
                        console.log(result[i].files);
                    }
                });
            }
        }

        delegate: ListItem {
            property string path: pathh
            id: litem
            width: parent.width
            height: Theme.itemSizeExtraSmall
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingMedium
            }
            onClicked: {
                console.log(file.text);
                console.log(path);
                if (file.text.slice(-1) =="/") {
                    lmodel.loadNew(path);
                    confusingPath = path;
                }
                else {
                    filePath=path;
                    pageStack.push(Qt.resolvedUrl("Editor2.qml"),{fileTitle: file.text})
                }

            }
            Label {
                id: file
                wrapMode: Text.WordWrap
                width: parent.width
                anchors.centerIn: parent
                text: files

            }
        }

    }
    Python {
        id: py

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./python'));
            importModule('addFile', function() {});
            importModule('openFile', function () {
                py.call('openFile.files', [projectPath+ "/"+projectName], function(result2) {
                    for (var i=0; i<result2.length; i++) {
                        lmodel.append(result2[i]);
                        console.log(result2[i].files);
                        console.log(result2[i].pathh);

                    }
                });
            });
        }
        onError: {
            console.log('python error: ' + traceback);
        }
        onReceived: console.log('Unhandled event: ' + data)
    }


    AddFileDialog {
        id: dialog
    }

}

