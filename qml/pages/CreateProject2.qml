import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4


Dialog {
    Column {
        anchors.fill: parent
        DialogHeader {
            acceptText: qsTr("Create")
        }
        TextField {
            id: projectN

            placeholderText: qsTr("Name of the project")
            width: parent.width
            validator: RegExpValidator { regExp: /.{1,}/ }
        }
    }
    canAccept: projectN.text !== "" ? true :false
    onDone: {
        if (projectN.text !== "") {
            if (result == DialogResult.Accepted) {

                projectName = projectN.text;
                py.call('createProject.create', [projectName,projectPath], function(result) {});


                console.log(projectQmlPath);
                //pageStack.replace(Qt.resolvedUrl("CreatorHome.qml")/*, {fullpath: projectPath +projectN.text+"/qml/"+projectN.text+".qml"}, {project: projectN.text}*/);

            }

        }

    }
    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./python'));
            importModule('createProject', function() {});

        }
        onError: {
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }
        onReceived: console.log('Unhandled event: ' + data)
    }
}

