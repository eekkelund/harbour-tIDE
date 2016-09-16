import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4


Page {
    id: page
    property int pid
    onStatusChanged: {
        if (status == PageStatus.Deactivating) {
            console.log("stoppinf")
            py.call('stopProject.kill', [],function(result) {
                console.log(result)
            });
            console.log("stoppinf")
        }
    }
    //onDestroyed: py.call('startProject.stop', [],function(result) {});
    PageHeader {
        id:hdr
        title: qsTr("Application output")
    }

    SilicaListView {
        id: outputList
        anchors.top: hdr.bottom
        anchors.bottom: parent.bottom
        anchors.left:parent.left
        anchors.right: parent.right
        model: ListModel { id: listModel }
        delegate: ListItem {
            id:listItem
            width: parent.width
            height: Theme.itemSizeExtraSmall
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingMedium
            }

            Label {
                id: outputText
                wrapMode: TextEdit.Wrap
                width: parent.width
                anchors.centerIn: parent
                text: out
            }
        }
        /*Component.onCompleted: {
            var add_item = function (reply) {
                //for (var n in reply)
                    listModel.append(reply);
            };/*
            actor.send({ from_qml : projectQmlPath}, {on_reply : add_item, on_progress: add_item})
            //listModel.append(put);

            actor.request("launch", {from_qml : projectQmlPath}, {on_reply : add_item, on_progress: add_item, on_error: add_item})

        }*/

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
                importModule('stopProject', function () {
                    py.call('stopProject.set_path', [projectQmlPath],function(result) {
                        console.log(result);
                    });
                    py.call('stopProject.init', [], function(result) {console.log(result)});
                    py.call('stopProject.start_proc', [], function(result) {console.log(result)});
                });

            }
            onError: {
                console.log('python error: ' + traceback);
            }
            //onReceived: console.log('Unhandled event: ' + data)//listModel.append(data);
        }

    }
}
