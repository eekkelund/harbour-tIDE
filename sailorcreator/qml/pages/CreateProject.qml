import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3




Page {
    id: page
    DockedPanel {
        id: errorPanel

        width: page.isPortrait ? parent.width : Theme.itemSizeExtraLarge + Theme.paddingLarge
        height: page.isPortrait ? Theme.itemSizeExtraLarge + Theme.paddingLarge : parent.height

        dock: page.isPortrait ? Dock.Top : Dock.Left
        Text {
            id:error
            //anchors.fill:parent
            anchors.centerIn: parent
            color: Theme.primaryColor
            font.pixelSize: Theme.fontSizeLarge
            font.bold: true
        }
        MouseArea {
            anchors.fill:parent
            onClicked: errorPanel.open = false;
        }
    }
    //allowedOrientations: Orientation.Landscape
    //Column {
    //  id: column
    // anchors.fill: parent
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
                            errorPanel.open =true
                            error.text =  qsTr("Projectname exists")
                        }
                        else {
                            console.log(projectQmlPath);
                            pageStack.replaceAbove(null, Qt.resolvedUrl("CreatorHome.qml"));
                        }
                    });



                }
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

    //}
}





