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

Page {
    id: page
    property string projectHomePath: projectPath+ "/"+projectName

    property string ext: ".qml"


    SilicaListView {
        id:fileList
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        VerticalScrollDecorator {}
        PullDownMenu {
            MenuItem {
                text: qsTr("Build the app")
                onClicked: {
                   // pageStack.push(Qt.resolvedUrl("BuildOutput.qml"))
                }
            }
            MenuItem {
                text: qsTr("Run the app")
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("AppOutput.qml"))
                }
            }
            MenuItem {
                text: qsTr("Add file")
                onClicked: {
                    pageStack.push(dialog, {path:projectHomePath})
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
                anchors.bottomMargin: Theme.paddingLarge
                x: Theme.paddingLarge
                text: qsTr("Select file to open")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
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
            }
            onClicked: {
                console.log(file.text);
                console.log(path);
                if (file.text.slice(-1) =="/") {
                    lmodel.loadNew(path);
                    projectHomePath = path;
                }
                else {
                    filePath=path;
                    singleFile =file.text
                    pageStack.push(Qt.resolvedUrl("Editor2.qml"))
                }

            }
            Label {
                id: file
                wrapMode: Text.WordWrap
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.paddingMedium
                text: files

            }
        }

    }
    Python {
        id: py

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./../python'));
            importModule('addFile', function() {});
            importModule('buildRPM', function() {});
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

