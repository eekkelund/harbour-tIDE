/*****************************************************************************
 *
 * Created: 2017 by Eetu Kahelin / eekkelund
 *
 * Copyright 2017 Eetu Kahelin. All rights reserved.
 *
 * This file may be distributed under the terms of GNU Public License version
 * 3 (GPL v3) as defined by the Free Software Foundation (FSF). A copy of the
 * license should have been included with this file, or the project in which
 * this file belongs to. You may also find the details of GPL v3 at:
 * http://www.gnu.org/licenses/gpl-3.0.txt
 *
 * If you have any questions regarding the use of this file, feel free to
 * contact the author of this file, or the owner of the project in which
 * this file belongs to.
*****************************************************************************/
import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id: splitPage
    property string fullFilePath
    allowedOrientations: Orientation.LandscapeMask
    property int editor:0

    Item {
        id: column1
        width: splitPage.width / 2
        anchors.left: parent.left
        height: splitPage.height

        EditorPage {
            id: editor1Page
            width: parent.width
            height: parent.height
            inSplitView:true
            drawer.parent: column1
            restoreD.onDone:{
                splitPage.fullFilePath = fullFilePath
                editor=1
            }
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

        EditorPage {
            id: editor2Page
            width: parent.width
            height: parent.height
            inSplitView: true
            drawer.parent: column2
            restoreD.onDone:{
                splitPage.fullFilePath = fullFilePath
                editor=2
            }

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
        switch(editor) {
        case 0:
            editor2Page.fullFilePath= fullFilePath
            editor1Page.fullFilePath= fullFilePath
            break;
        case 1:
            editor1Page.fullFilePath= fullFilePath
            break;
        case 2:
            editor2Page.fullFilePath= fullFilePath
            break;
        }
        editor2Page.pageStatusChange(splitPage)
        editor1Page.pageStatusChange(splitPage)
        editor2Page.ready = true
        editor1Page.ready =true
    }

}
