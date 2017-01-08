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
    PageHeader {
        id:hdr
        title: qsTr("Create new project")
    }
    Column {
        id: column
        anchors.top: hdr.bottom
        anchors.bottom: parent.bottom
        anchors.left:parent.left
        anchors.right: parent.right
        TextField {
            id: projectN
            inputMethodHints: Qt.ImhNoPredictiveText
            placeholderText: qsTr("Name of the project")
            width: parent.width
            validator: RegExpValidator { regExp: /.{1,}/ }
            EnterKey.enabled: text.length > 0
            EnterKey.iconSource: "image://theme/icon-m-enter-accept"
            EnterKey.onClicked: create();
        }
        Button {
            id:add
            anchors.horizontalCenter: column.horizontalCenter
            text:qsTr("Create project")
            onPressed: create();
        }

    }
    function create(){
        if (projectN.text !== "") {
            projectName = projectN.text;
            py.call('createProject.create', [projectName,projectPath], function(result) {
                if (result===false){
                    //Show warning
                    showError("Project name exists");
                }
                else {
                    pageStack.replaceAbove(getBottomPageId(), Qt.resolvedUrl("CreatorHome.qml"));
                }
            });

            function getBottomPageId()
            {
                return pageStack.find( function(page)
                {
                    return (page._depth === 0)
                })
            }


        }
    }
    Component.onCompleted: projectN.forceActiveFocus()

    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./../python'));
            importModule('createProject', function() {});

        }
        onError: {
            showError(traceback)
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }
    }
}





