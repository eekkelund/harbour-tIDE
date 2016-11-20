import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3


Page {
    id: page
    property int pid
    /*onStatusChanged: {
        if (status == PageStatus.Deactivating) {
            console.log("stoppinf")
            py.call('stopProject.kill', [],function(result) {
                console.log(result)
            });
            console.log("stopping")
        }
    }*/
    PageHeader {
        id:hdr
        title: qsTr("Build output")
    }

    SilicaListView {
        id: outputList
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
                    text: "Copy"
                    onClicked: Clipboard.text=outputText.text
                }
            }
        }
        Python {
            id: py

            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('./python'));
                setHandler('output', function(text) {
                    listModel.append(text);
                    //outputText.text= text+"\n";
                });
                setHandler('pid', function(pidi) {
                    pid=pidi
                    console.log(pid)
                    //outputText.text= text+"\n";
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
            //onReceived: console.log('Unhandled event: ' + data)//listModel.append(data);
        }

    }
}
