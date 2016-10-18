import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4


Page {
    id: page

    SilicaListView {
        header: Column {
            width: parent.width
            //x: Theme.paddingLarge
            spacing: Theme.paddingMedium

            PageHeader  {
                width: parent.width

                title: qsTr("Open File")
                //font.pixelSize: Theme.fontSizeExtraLarge
                //color: Theme.highlightColor
                //horizontalAlignment: Text.AlignRight
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
//            Label {
//                title: qsTr("OpenFile")
//                color: Theme.highlightColor
//                horizontalAlignment: Text.AlignRight
//            }


//            Label {
//                anchors.topMargin: Theme.paddingMedium
//                anchors.bottomMargin: Theme.paddingMedium
//                text: qsTr("Select a file to open in editor")
//            }
        }

        id:fileList
        model: ListModel{id: lmodel}
        //anchors.fill: parent
        anchors.top: parent.top
        width: parent.width
        height: parent.height

        VerticalScrollDecorator {}


        delegate: ListItem {
            id: litem
            width: parent.width
            height: Theme.itemSizeExtraSmall
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingMedium
            }
            onClicked: {
                console.log(file.text)
            }
            Label {
                id: file
                wrapMode: Text.WordWrap
                width: parent.width
                anchors.centerIn: parent
                text: files

            }


            /*Label{
                id:dir
                text: dirs
                wrapMode: Text.WordWrap
                width: parent.width

            }*/
            /*Label {
                id: file
                text: files
                //wrapMode: Text.WordWrap
                anchors.centerIn: parent
                //width: parent.width

                anchors {
                    top: dir.bottom
                    left:parent.left
                    right:parent.right
                }

            }*/
        }

    }
    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./python'));
            importModule('openFile', function () {

                /*py.call('openFile.dirss', [projectName], function(result) {
                    for (var i=0; i<result.length; i++) {
                        lmodel.append(result[i]);
                    }
                });*/
                py.call('openFile.files', [projectPath, "lol"], function(result2) {
                    console.log(result2);
                    for (var i=0; i<result2.length; i++) {
                        lmodel.append(result2[i]);
                        console.log(result2[i].files);
                        console.log("resultsadsa");
                    }
                });
            });
        }
        onError: {
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }
        onReceived: console.log('Unhandled event: ' + data)
    }
}
