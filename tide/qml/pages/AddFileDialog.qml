/*****************************************************************************
 *
 * Created: 2016 by Eetu Kahelin / eekkelund
 *
 * Copyright 2016 Eetu Kahelin. All rights reserved.
 *
 * This file may be distributed under the terms of GNU Public License version
 * 3 (GPL v3) as defined by the Free Software Foundation (FSF). A copy of the
 * license should have been included with this file, or the project in which
 * this file belongs to. You may also find the details of GPL v3 at:
 * http://www.gnu.org/licenses/gpl-3.0.txt
 *
 * If you have any questions regarding the use of this file, feel free to
 * contact the author of this file, or the owner of the project in which
 * this file belongs to.
*****************************************************************************/
import QtQuick 2.2
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
            singleFile=fName+ext
            dialog.acceptDestination=Qt.resolvedUrl("Editor2.qml")
        }
    }
    onOpened:{
        acceptDestination=Qt.resolvedUrl("ProjectHome.qml");

    }

}

