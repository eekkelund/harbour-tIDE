import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3

Dialog {

    property string path
    acceptDestination:Qt.resolvedUrl("ProjectHome.qml")
    acceptDestinationAction: PageStackAction.Replace
    DialogHeader {
        id:dHdr
        acceptText: qsTr("Add")
    }


    //  anchors.fill: parent
    SilicaListView {
        width: page.width
        contentHeight: row.height
        anchors.top: dHdr.bottom
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.left: parent.left


        model: VisualItemModel {
            Row {
                id:row
                anchors.fill: parent
                //width: parent.width
                //anchors.top: dHdr.bottom
                //anchors.bottom: parent.bottom
                //anchors.right: parent.right
                //anchors.left: parent.left
                TextField {
                    id: fileName
                    inputMethodHints: Qt.ImhNoPredictiveText
                    placeholderText: qsTr("Name of the file")
                    width: parent.width/2
                    validator: RegExpValidator { regExp: /.+/ }
                }
                ComboBox {
                    id:cBox
                    width: parent.width / 2
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
        }
    }

    canAccept: fileName.text !== "" ? true :false
    onAccepted: {
        if (fileName.text !== "") {
            var fName = fileName.text;
            py.call('addFile.createFile', [fName,ext,path], function() {
            });
            filePath = (path +"/"+ fName + ext)
            lmodel.loadNew(path);
            fileName.focus= false;
            fileName.text = ""
            cBox.currentIndex = 0
            dialog.acceptDestination=Qt.resolvedUrl("Editor.qml")
            //pageStack.replace(Qt.resolvedUrl("Editor.qml"))

        }
    }
    onOpened:{
        acceptDestination=Qt.resolvedUrl("ProjectHome.qml");

    }

}

