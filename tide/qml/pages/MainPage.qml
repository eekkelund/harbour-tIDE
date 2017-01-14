/*****************************************************************************
 *
 * Created: 2016 by Eetu Kahelin / eekkelund
 *
 * Copyright 2016 Eetu Kahelin. All rights reserved.
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
import io.thp.pyotherside 1.3

Page{
    id:mainPage
    property bool hadArgs: false

    function openEditor(chooserPath){
        pageStack.replaceAbove(pageStack.previousPage(), Qt.resolvedUrl("EditorPage.qml"),{fullFilePath: chooserPath})
        pageStack.nextPage();
    }

    SilicaFlickable {
        anchors.top: parent.top
        width: parent.width
        height: parent.height
        PullDownMenu {
            MenuItem {
                text: qsTr("About & Help")
                onClicked: pageStack.push(Qt.resolvedUrl("AboutPage.qml"))
            }
            MenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(Qt.resolvedUrl("SettingsPage.qml"))
            }
        }
        Column {
            id: header
            width: parent.width
            spacing: Theme.paddingMedium
            PageHeader  {
                width: parent.width
                title: "tIDE"
            }
            Label {
                id:topLabel
                width: parent.width
                anchors.bottomMargin: Theme.paddingLarge
                x: Theme.paddingLarge
                text: qsTr("transportable IDE")
                color: Theme.secondaryHighlightColor
                font.pixelSize: Theme.fontSizeLarge
            }
        }
        Button{
            id:projects
            preferredWidth: Theme.buttonWidthLarge
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: header.bottom
                topMargin: Theme.paddingLarge *2
            }
            text: qsTr("Projects")
            onClicked: pageStack.push(Qt.resolvedUrl("CreatorHome.qml"))
        }
        Button{
            id:file
            preferredWidth: Theme.buttonWidthLarge
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: projects.bottom
                topMargin: Theme.paddingLarge
            }
            text: qsTr("Edit single file")
            onClicked: pageStack.push(Qt.resolvedUrl("FileManagerPage.qml"),{callback:openEditor})
        }
    }

    onStatusChanged:{
        if((status !== PageStatus.Active)){
            return;
        }
        else{
            if(!hadArgs){
                var args = Qt.application.arguments
                if (args.length > 1) {
                    filePath=args[1]
                    hadArgs = true
                    pageStack.push(Qt.resolvedUrl("EditorPage.qml"),{fullFilePath: args[1]})
                }
            }
        }

    }
}
