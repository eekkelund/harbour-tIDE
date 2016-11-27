import QtQuick 2.2
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3


Dialog{
    Column{
        width: parent.width
        DialogHeader {}
        Label{
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter
            text: qsTr("Restore autosaved version?")
        }
    }
    onAccepted: {
        py.call('editFile.openAutoSaved', [filePath], function(result) {
            documentHandler.text = result.text;
            fileTitle=result.fileTitle
        })
    }
    onRejected:{
        py.call('editFile.openings', [filePath], function(result) {
            documentHandler.text = result.text;
            fileTitle=result.fileTitle
            py.call('editFile.savings', [filePath,result.text], function(result) {
                fileTitle=result
            });
        })

    }

}
