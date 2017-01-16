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

CoverBackground {
    Column {
        width: parent.width
        anchors.centerIn: parent
        spacing: Theme.paddingMedium

        Image {
            anchors.horizontalCenter: parent.horizontalCenter
            width: Theme.iconSizeLarge
            height: Theme.iconSizeLarge
            source: closestMatchingIcon()
               sourceSize.width: width
               sourceSize.height: height

               function closestMatchingIcon() {
                   var icon = "harbour-tide"
                   if(rootMode) icon = icon+"-root"

                   if (width <= 500) {
                       return "/usr/share/icons/hicolor/86x86/apps/"+icon+".png"
                   } else if (width <= 100) {
                       return "/usr/share/icons/hicolor/108x108/apps/"+icon+".png"
                   } else {
                       return "/usr/share/icons/hicolor/256x256/apps/"+icon+".png"
                   }
               }
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            text: rootMode ? "root@tIDE" : "tIDE"
        }
    }
}


