import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import org.nemomobile.notifications 1.0

Page {
    id: page
    Notification{
        id:notification
    }
    function showError(message) {
        notification.category="x-nemo.example"
        notification.previewBody = qsTr("Projectname exists");
        notification.close();
        notification.publish();
    }
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
        }
        Button {
            id:add
            anchors.horizontalCenter: column.horizontalCenter
            text:qsTr("Create project")
            onPressed: {
                if (projectN.text !== "") {
                    projectName = projectN.text;
                    py.call('createProject.create', [projectName,projectPath], function(result) {
                        if (result===false){
                            //Show warning
                            showError();
                        }
                        else {
                            console.log(projectQmlPath);
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
        }

    }

    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./../python'));
            importModule('createProject', function() {});

        }
        onError: {
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }
        onReceived: console.log('Unhandled event: ' + data)
    }
}





