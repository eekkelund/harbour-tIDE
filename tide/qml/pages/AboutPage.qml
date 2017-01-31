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

Page {
    id: page
    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height + Theme.paddingLarge
        VerticalScrollDecorator {}

        PullDownMenu {
            MenuItem {
                text: qsTr("License: GPLv3")
                onClicked: Qt.openUrlExternally("https://www.gnu.org/licenses/gpl.txt")
            }
            MenuItem {
                text: qsTr("GitHub")
                onClicked: Qt.openUrlExternally("https://github.com/eekkelund/harbour-tIDE")
            }

            MenuItem {
                text: qsTr("Report an issue")
                onClicked: Qt.openUrlExternally("https://github.com/eekkelund/harbour-tIDE/issues")
            }
        }

        Column {
            id: column
            width: parent.width
            spacing: Theme.paddingMedium
            PageHeader {
                id: header
                title: qsTr("About")
            }
            Image {
                id: logo
                anchors.horizontalCenter: parent.horizontalCenter
                source: "/usr/share/icons/hicolor/108x108/apps/harbour-tide.png"
            }
            Column {
                anchors {
                    left: parent.left
                    right: parent.right
                }
                Label {
                    id: tide
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    font.pixelSize: Theme.fontSizeLarge
                    text: "tIDE"
                }
                Label {
                    id: about
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: Text.WordWrap
                    text: qsTr("transportable IDE for SailfishOS devices.")
                }
                Label {
                    id: ver
                    anchors {
                        left: parent.left
                        right: parent.right
                    }
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryColor
                    text: qsTr("Version") + " " + Qt.application.version
                }
            }
            ExpandingSection {
                buttonHeight: Theme.itemSizeMedium
                title:  qsTr("Features")
                content.sourceComponent: Column {

                    Label {
                        wrapMode: Text.WordWrap
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        font.bold: true
                        text: qsTr("Basic IDE features:")
                    }
                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        text: qsTr("Syntax highlighting (QML, JS & Python)") + "\n"+ qsTr("Project template creation for SailfishOS") + "\n"+ qsTr("Autocomplete (Installs new keyboard)") + "\n"+ qsTr("Running your application") + "\n"+ qsTr("Application output & debug log") + "\n"+ qsTr("Building a RPM(experimental)") + "\n"+ qsTr("Predictive text (QML, JS & Python)")+ "\n"+ qsTr("Installing built RPM")
                    }
                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        font.bold: true
                        text: qsTr("Normal text editor features including:")
                    }
                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        text:qsTr("Line numbers (experimental)") + "\n"+ qsTr("Autosave") + "\n" +qsTr("Themes") + "\n" +qsTr("Font settings") + "\n" +qsTr("Indentation") + "\n"+ qsTr("Redo/Undo") + "\n"+ qsTr("Search") + "\n"+ qsTr("Launch from terminal (harbour-tide /path/to/file.txt)")+ "\n"+ qsTr("Change files on the fly")+ "\n"+ qsTr("Split view. And possibility to move separator")
                    }
                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        font.bold: true
                        text: qsTr("Root mode features:")
                    }
                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        text:qsTr("Edit UI, app or system files. You name it!") + "\n"+ qsTr("Possibility to run applications in /usr/share")
                    }
                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        font.bold: true
                        text: qsTr("Keyboard:")
                    }
                    Label {
                        width: parent.width
                        wrapMode: Text.WordWrap
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        text:qsTr("Predictive text depending on what file opened") + "\n"+ qsTr("Tabulator button on Sym view") + "\n"+ qsTr("Arrow keys") + "\n"+ qsTr("Basic hardware support including common shortcuts")
                    }
                }
            }
            ExpandingSection {
                buttonHeight: Theme.itemSizeMedium
                title: qsTr("Instructions")
                content.sourceComponent: Column {
                    Label {
                        textFormat: Text.StyledText
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text: qsTr("New keyboard is activated from: Settings - Text input - Keyboards - Develop")
                    }
                    Label {
                        textFormat: Text.StyledText
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text: qsTr("Built RPM's are located at:") +" /home/nemo/rpmbuild/RPMS/*architecture*/"
                    }
                    Label {
                        textFormat: Text.StyledText
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text: qsTr("Projects are located at:") +" /home/nemo/tIDE/Projects"
                    }
                }
            }
            ExpandingSection {
                buttonHeight: Theme.itemSizeMedium
                title: qsTr("Contributors")
                content.sourceComponent: Column {
                    SectionHeader {
                        text: qsTr("Developer")
                    }

                    Label {
                        linkColor: Theme.primaryColor
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.highlightColor
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text: "Eetu Kahelin" +" <br> " +"<a href='https://twitter.com/eekkelund'>@eekkelund</a>"
                        onLinkActivated: Qt.openUrlExternally(link)
                    }

                    SectionHeader {
                        text: qsTr("Contributors")
                    }
                    Label {
                        textFormat: Text.StyledText
                        linkColor: Theme.primaryColor
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text:  "<a href='https://github.com/wellef'>wellef</a> "+": "+ qsTr("Project deleting, wrap mode setting for the editor, Python bug fixes")
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    Label {
                        textFormat: Text.StyledText
                        linkColor: Theme.primaryColor
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text:"<a href='https://github.com/Schturman'>Schturman</a> "+" and "+"< <a href='https://github.com/elros34'>elros34</a>" +": "+ qsTr("Start as root script")
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    SectionHeader {
                        text: qsTr("Translations")
                    }
                    Label {
                        textFormat: Text.StyledText
                        linkColor: Theme.primaryColor
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text:  "<a href='https://github.com/eson57'>eson57</a> "+": "+ qsTr("Swedish")
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    Label {
                        textFormat: Text.StyledText
                        linkColor: Theme.primaryColor
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text:  "<a href='https://github.com/d9h02f'>d9h02f</a> "+": "+ qsTr("Dutch")
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    Label {
                        textFormat: Text.StyledText
                        color: Theme.primaryColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        anchors {
                            topMargin: Theme.paddingSmall
                            left: parent.left
                            right: parent.right
                        }
                        text:  qsTr("Thank you! :)")
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    SectionHeader {
                        text: qsTr("Credits")
                    }
                    Label {
                        textFormat: Text.StyledText
                        linkColor: Theme.primaryColor
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text: qsTr("Base of the keyboard: Jolla's")+" "+ "<a href='https://github.com/maliit'>maliit keyboard</a> "+" "+ qsTr("and SaberAltria's") +" "+ "<a href='https://github.com/SaberAltria/harbour-dolphin-keyboard'>Dolphin keyboard.</a>"
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    Label {
                        textFormat: Text.StyledText
                        linkColor: Theme.primaryColor
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text: qsTr("Some highlighting rules and indentation:") +" Oleg Yadrov's "+" <a href='https://github.com/olegyadrov/qmlcreator'>QML Creator</a>"
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    Label {
                        textFormat: Text.StyledText
                        linkColor: Theme.primaryColor
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        anchors.margins: Theme.paddingLarge
                        text: qsTr("SettingsPage slider:")+" "+" <a href='https://github.com/Ancelad'>Ancelad</a>"
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    Label {
                        textFormat: Text.StyledText
                        linkColor: Theme.primaryColor
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        anchors.margins: Theme.paddingLarge
                        text: qsTr("Icon:")+" "+" <a href='https://github.com/gri4994'>gri4994</a>"+" and svg "+"<a href='https://github.com/topiasv-p'>topiasv-p</a>"
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                    Label {
                        textFormat: Text.StyledText
                        linkColor: Theme.primaryColor
                        color: Theme.highlightColor
                        wrapMode: Text.WordWrap
                        font.pixelSize: Theme.fontSizeSmall
                        anchors {
                            left: parent.left
                            leftMargin: Theme.horizontalPageMargin
                            right: parent.right
                            rightMargin: Theme.horizontalPageMargin
                        }
                        text: qsTr("Dedicated to")+" "+ "<a href='https://talk.maemo.org/member.php?u=60993'>Gido Griese</a>"
                        onLinkActivated: Qt.openUrlExternally(link)
                    }
                }
            }
        }
    }
}
