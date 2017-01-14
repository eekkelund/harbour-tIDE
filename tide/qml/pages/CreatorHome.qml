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
    property string labelText
    function goToProjects(){
        if(projectPath=="/usr/share/"){
            labelText=qsTr("/usr/share/")
        }else if(projectPath=="/media/sdcard/"){
            labelText=qsTr("SD Card")
        }else{
            labelText=qsTr("Open existing project")
        }
        py.call('openFile.projects', [projectPath], function(result2) {
            listModel.clear()
            if (result2.length < 1){
                labelText=qsTr("No projects yet")
            }
            else {
                for (var i=0; i<result2.length; i++) {
                    listModel.append(result2[i]);
                }
            }
        });
    }

    SilicaListView {
        id:projectList
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        PullDownMenu {
            MenuItem {
                text:  projectPath=="/media/sdcard/" ? qsTr("Go to own projects"): qsTr("Go to SD Card")
                onClicked: {
                    if(projectPath=="/media/sdcard/") {
                        projectPath=homePath+"/Projects"
                    }else projectPath="/media/sdcard/"
                    goToProjects()
                }
            }
            MenuItem {
                text:  projectPath=="/usr/share/" ? qsTr("Go to own projects"): qsTr("Go to /usr/share/")
                onClicked: {
                    if(projectPath=="/usr/share/") {
                        projectPath= homePath+"/Projects"
                    }else projectPath="/usr/share/"
                    goToProjects()
                }
            }
            MenuItem {
                text: qsTr("Create new project")
                onClicked: pageStack.push(Qt.resolvedUrl("CreateProject.qml"))
            }
        }
        header: Column {
            width: parent.width
            spacing: Theme.paddingMedium
            PageHeader  {
                width: parent.width
                title: qsTr("Projects")
            }
            Label {
                id:topLabel
                width: parent.width
                anchors.bottomMargin: Theme.paddingLarge
                x: Theme.paddingLarge
                text: labelText
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
        }
        model: ListModel { id: listModel }
        delegate: ListItem {
            id:listItem
            width: parent.width
            height: Theme.itemSizeSmall +menu.height
            anchors {
                left: parent.left
                right: parent.right
            }

            Label {
                id: name
                wrapMode: Text.WordWrap
                width: parent.width
                anchors.verticalCenter: parent.verticalCenter
                x: Theme.paddingMedium
                text: project
            }
            onClicked: {
                projectName = name.text
                var projectHome = pageStack.push(Qt.resolvedUrl("ProjectHome.qml"))
                projectHome.projectDeleted.connect(function (){listModel.remove(index)})
            }
            menu: ContextMenu {
                MenuItem {
                    text: qsTr("Delete")
                    onClicked: listItem.remorseAction(qsTr("Deleting project"), function () {
                        py.call('deleteProject.remove', [projectPath, project], function (success) {
                            if (success)
                                listModel.remove(index);
                            else
                                console.log("Unable to remove project");
                        })
                    })
                }
            }

        }
    }

    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./../python'));
            importModule('createProject', function() {});
            importModule('deleteProject', function() {})
            importModule('openFile', function () {
                py.call('openFile.projects', [projectPath], function(result2) {
                    if (result2.length < 1){
                        labelText=qsTr("No projects yet")
                    }
                    else {
                        labelText=qsTr("Open an existing project")
                        for (var i=0; i<result2.length; i++) {
                            listModel.append(result2[i]);
                        }
                    }
                });
            });
        }
        onError: {
            showError(traceback)
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }
    }
}



