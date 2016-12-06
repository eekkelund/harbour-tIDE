import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3

Page {
    id: page
    property string labelText
    SilicaListView {
        id:projectList
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        PullDownMenu {
            MenuItem {
                text:  projectPath=="/usr/share/" ? qsTr("Go to own projects"): qsTr("Open /usr/share/")
                onClicked: goToProjects()

                function goToProjects(){
                    if(projectPath=="/usr/share/"){
                        projectPath= homePath+"/Projects"
                        labelText=qsTr("Open existing project")
                    }else{
                        projectPath="/usr/share/"
                        labelText=qsTr("/usr/share/")
                    }
                    py.call('openFile.projects', [projectPath], function(result2) {
                        listModel.clear()
                        if (result2.length < 1){
                            labelText=qsTr("No projects yet")
                        }
                        else {
                            for (var i=0; i<result2.length; i++) {
                                listModel.append(result2[i]);
                                console.log(result2[i].project);
                            }
                        }
                    });
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
            height: Theme.itemSizeExtraSmall
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
                pageStack.push(Qt.resolvedUrl("ProjectHome.qml"))

            }

        }
    }

    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./../python'));
            importModule('createProject', function() {});
            importModule('openFile', function () {
                py.call('openFile.projects', [projectPath], function(result2) {
                    if (result2.length < 1){
                        labelText=qsTr("No projects yet")
                    }
                    else {
                        labelText=qsTr("Open existing project")
                        for (var i=0; i<result2.length; i++) {
                            listModel.append(result2[i]);
                            console.log(result2[i].project);
                        }
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



