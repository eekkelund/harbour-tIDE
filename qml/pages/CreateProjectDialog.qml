import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4

Dialog {
    id:dialog
    acceptDestination:Qt.resolvedUrl("CreatorHome.qml")
    acceptDestinationAction: PageStackAction.Replace
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
    onAccepted: {
        if (projectN.text !== "") {

            projectName = projectN.text;
            py.call('createProject.create', [projectName,projectPath], function(result) {});
            loadProjects();
            dialog.acceptDestination=Qt.resolvedUrl("ProjectHome.qml")
            console.log(projectQmlPath);
            //pageStack.replace(Qt.resolvedUrl("CreatorHome.qml")/*, {fullpath: projectPath +projectN.text+"/qml/"+projectN.text+".qml"}, {project: projectN.text}*/);

        }
    }
    onOpened:{
        acceptDestination=Qt.resolvedUrl("CreatorHome.qml");

    }

}
