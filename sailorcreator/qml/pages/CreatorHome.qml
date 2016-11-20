import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3


Page {
    id: page
    property string labelText: qsTr("Open existing project")

    SilicaListView {
        id:projectList
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        PullDownMenu {
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
                title: qsTr("TITLE")
            }
            Label {
                id:topLabel
                width: parent.width
                //anchors.topMargin: Theme.paddingMedium
                anchors.bottomMargin: Theme.paddingLarge
                x: Theme.paddingLarge
                text: labelText
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
                //horizontalAlignment: Text.AlignRight
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
                console.log(name.text)
                projectName = name.text
                pageStack.push(Qt.resolvedUrl("ProjectHome.qml"))

            }

        }
    }

    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./python'));
            importModule('startProject', function() {});
            importModule('createProject', function() {});
            importModule('openFile', function () {
                py.call('openFile.projects', [projectPath], function(result2) {
                    if (result2 === 0){
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

    function loadProjects() {
        listModel.clear();
        py.call('openFile.projects', [projectPath], function(result2) {
            for (var i=0; i<result2.length; i++) {
                listModel.append(result2[i]);
                console.log(result2[i].project);
            }
        });

    }
}



