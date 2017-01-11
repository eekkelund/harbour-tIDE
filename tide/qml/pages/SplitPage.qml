import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: splitPage
    property string fullFilePath
    allowedOrientations: Orientation.LandscapeMask

    Item {
        id: column1
        width: splitPage.width / 2
        anchors.left: parent.left
        height: splitPage.height

        Editor2 {
            id: editor1Page
            width: parent.width
            height: parent.height
            inSplitView:true
            drawer.parent: column1
            myeditor.onTextChanged: {
                if(ready && editor2Page.ready && !editor1Page.drawer.opened){
                    if(editor1Page.fullFilePath===editor2Page.fullFilePath) {
                        editor2Page.myeditor.text = editor1Page.myeditor.text
                    }
                }
            }
            onFileTitleChanged: {
                if(ready && editor2Page.ready && !editor1Page.drawer.opened){
                    if(editor1Page.fullFilePath===editor2Page.fullFilePath) {
                         editor2Page.fileTitle= editor1Page.fileTitle
                    }
                }
            }
            myeditor.onFocusChanged: {
                if(myeditor.focus) py.call('editFile.changeFiletype', [fileType], function(result){});
            }
        }

    }
    Rectangle {
        id: line
        height: parent.height
        width: Theme.paddingSmall
        color: Theme.highlightDimmerColor
        anchors.horizontalCenter: parent.horizontalCenter
    }
    Item {
        id: column2
        width: splitPage.width / 2
        anchors.right: parent.right
        height: splitPage.height

        Editor2 {
            id: editor2Page
            width: parent.width
            height: parent.height
            inSplitView: true
            drawer.parent: column2
            myeditor.onTextChanged: {
                if(ready && editor1Page.ready && !editor2Page.drawer.opened){
                    if(editor1Page.fullFilePath===editor2Page.fullFilePath) {
                        editor1Page.myeditor.text = editor2Page.myeditor.text
                    }
                }
            }
            onFileTitleChanged: {
                if(ready && editor1Page.ready && !editor2Page.drawer.opened){
                    if(editor1Page.fullFilePath===editor2Page.fullFilePath) {
                         editor1Page.fileTitle= editor2Page.fileTitle
                    }
                }
            }
            myeditor.onFocusChanged: {
                if(myeditor.focus) py.call('editFile.changeFiletype', [fileType], function(result){});
            }
        }

    }
    onStatusChanged:{
        editor2Page.fullFilePath= fullFilePath
        editor1Page.fullFilePath= fullFilePath
        editor2Page.pageStatusChange(splitPage)
        editor1Page.pageStatusChange(splitPage)
    }

}
