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
    property int pid
    onStatusChanged: {
        if (status == PageStatus.Deactivating) {
            py.call('buildRPM.kill', [],function(result) {console.log(result)});
        }
    }
    PageHeader {
        id:hdr
        title: qsTr("Build output")
    }

    SilicaListView {
        id: outputList
        PullDownMenu {
            id:pulldown
            visible: false
            /*MenuItem {
                text: qsTr("Install")
                onClicked: {
                    py.call('buildRPM.kill', [], function(result) {console.log(result)});
                    listModel.clear()
                }
            }*/
        }
        anchors.top: hdr.bottom
        anchors.bottom: parent.bottom
        anchors.left:parent.left
        anchors.right: parent.right
        clip: true
        model: ListModel { id: listModel }
        delegate: ListItem {
            id:listItem
            width: parent.width
            contentHeight: outputText.height
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingMedium
            }
            Label {
                id: outputText
                x: Theme.paddingLarge
                wrapMode: TextEdit.Wrap
                width: parent.width
                anchors.centerIn: parent
                text: out
            }
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Copy")
                    onClicked: Clipboard.text=outputText.text
                }
            }
        }
        Python {
            id: py

            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('./../python'));
                setHandler('output', function(text) {
                    listModel.append(text);
                    if (text.out.search("Wrote")>-1){
                        pulldown.visible =true
                    }
                });
                setHandler('pid', function(pidi) {
                    pid=pidi
                    console.log(pid)
                });
                importModule('buildRPM', function () {
                    py.call("buildRPM.createBuildDir", [projectName, buildPath, projectPath],function() {});
                    py.call('buildRPM.init', [], function(result) {console.log(result)});
                    py.call('buildRPM.start_proc', [], function(result) {console.log(result)});

                });

            }
            onError: {
                console.log('python error: ' + traceback);
            }
        }

    }
}
