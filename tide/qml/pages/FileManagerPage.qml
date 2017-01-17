/*
*  Thanks belongs to coderus+Jolla! https://github.com/CODeRUS/splashscreen-changer/blob/master/settings/SecondPage.qml
*/

import QtQuick 2.2
import Sailfish.Silica 1.0
import Nemo.FileManager 1.0
import Sailfish.FileManager 1.0
import io.thp.pyotherside 1.3

Page {
    id: page
    allowedOrientations: Orientation.All

    property alias path: fileModel.path
    property string ext: ""
    property string title
    property bool showFormat
    signal formatClicked
    property var callback

    backNavigation: !FileEngine.busy

    FileModel {
        id: fileModel

        path: rootMode ? "/" : homePath
        active: page.status === PageStatus.Active
        onError: {
            showError(traceback)
            console.log("###", fileName, error)
        }
    }
    SilicaListView {
        id: fileList

        opacity: FileEngine.busy ? 0.6 : 1.0
        Behavior on opacity { FadeAnimator {} }

        anchors.fill: parent
        PullDownMenu {
            MenuItem {
                enabled:rootMode
                visible:enabled
                text:fileModel.path=="/"? qsTr("Go /usr/share"):qsTr("Go to root")
                onClicked: fileModel.path=="/"?fileModel.path="/usr/share":fileModel.path="/"
            }
            MenuItem {
                enabled:!rootMode
                visible:enabled
                text:fileModel.path=="/media/sdcard/"? qsTr("Go to home"):qsTr("Go SD Card")
                onClicked: fileModel.path=="/media/sdcard/"?fileModel.path=homePath:fileModel.path="/media/sdcard/"
            }

            MenuItem {
                text:qsTr("Add file")
                onClicked: pageStack.push(dialog, {path:path, accDest:"FileManagerPage.qml"})
            }
        }
        model: fileModel

        header: PageHeader {
            title: path == homePath && page.title.length > 0 ? page.title
                                                             : page.path.split("/").pop()
            _titleItem.color: rootMode ? reverseColor(Theme.highlightColor) :Theme.highlightColor
        }

        delegate: ListItem {
            id: fileItem

            enabled: {
                var ena=true
                if (model.isDir) {
                    ena = true
                } else {
                    switch (model.mimeType) {
                    case "application/vnd.android.package-archive":
                        ena = false
                        break
                    case "application/x-rpm":
                        ena=false
                        break
                    case "text/vcard":
                        ena = true
                        break
                    case "text/plain":
                    case "text/x-vnote":
                        ena = true
                        break
                    case "application/pdf":
                        ena = false
                        break
                    case "application/vnd.oasis.opendocument.spreadsheet":
                    case "application/x-kspread":
                    case "application/vnd.ms-excel":
                    case "text/csv":
                    case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet":
                    case "application/vnd.openxmlformats-officedocument.spreadsheetml.template":
                        ena = false
                        break
                    case "application/vnd.oasis.opendocument.presentation":
                    case "application/vnd.oasis.opendocument.presentation-template":
                    case "application/x-kpresenter":
                    case "application/vnd.ms-powerpoint":
                    case "application/vnd.openxmlformats-officedocument.presentationml.presentation":
                    case "application/vnd.openxmlformats-officedocument.presentationml.template":
                        ena = false
                        break
                    case "application/vnd.oasis.opendocument.text-master":
                    case "application/vnd.oasis.opendocument.text":
                    case "application/vnd.oasis.opendocument.text-template":
                    case "application/msword":
                    case "application/rtf":
                    case "application/x-mswrite":
                    case "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
                    case "application/vnd.openxmlformats-officedocument.wordprocessingml.template":
                    case "application/vnd.ms-works":
                        ena = false
                        break
                    default:
                        if (mimeType.indexOf("audio/") == 0) {
                            ena=false
                        } else if (mimeType.indexOf("image/") == 0) {
                            ena=false
                        } else if (mimeType.indexOf("video/") == 0) {
                            ena=false
                        }
                    }
                    return ena
                }
            }

            width: ListView.view.width
            contentHeight:Theme.itemSizeMedium
            Row {
                anchors.fill: parent
                spacing: Theme.paddingLarge
                Rectangle {
                    width: height
                    height: parent.height
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: Theme.rgba(Theme.primaryColor, 0.1) }
                        GradientStop { position: 1.0; color: "transparent" }
                    }

                    Image {
                        anchors.centerIn: parent
                        source: {
                            var iconSource
                            if (model.isDir) {
                                iconSource = "image://theme/icon-m-file-folder"
                            } else {
                                var iconType = "other"
                                switch (model.mimeType) {
                                case "application/vnd.android.package-archive":
                                    iconType = "apk"
                                    break
                                case "application/x-rpm":
                                    iconType = "rpm"
                                    break
                                case "text/vcard":
                                    iconType = "vcard"
                                    break
                                case "text/plain":
                                case "text/x-vnote":
                                    iconType = "note"
                                    break
                                case "application/pdf":
                                    iconType = "pdf"
                                    break
                                case "application/vnd.oasis.opendocument.spreadsheet":
                                case "application/x-kspread":
                                case "application/vnd.ms-excel":
                                case "text/csv":
                                case "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet":
                                case "application/vnd.openxmlformats-officedocument.spreadsheetml.template":
                                    iconType = "spreadsheet"
                                    break
                                case "application/vnd.oasis.opendocument.presentation":
                                case "application/vnd.oasis.opendocument.presentation-template":
                                case "application/x-kpresenter":
                                case "application/vnd.ms-powerpoint":
                                case "application/vnd.openxmlformats-officedocument.presentationml.presentation":
                                case "application/vnd.openxmlformats-officedocument.presentationml.template":
                                    iconType = "presentation"
                                    break
                                case "application/vnd.oasis.opendocument.text-master":
                                case "application/vnd.oasis.opendocument.text":
                                case "application/vnd.oasis.opendocument.text-template":
                                case "application/msword":
                                case "application/rtf":
                                case "application/x-mswrite":
                                case "application/vnd.openxmlformats-officedocument.wordprocessingml.document":
                                case "application/vnd.openxmlformats-officedocument.wordprocessingml.template":
                                case "application/vnd.ms-works":
                                    iconType = "formatted"
                                    break
                                default:
                                    if (mimeType.indexOf("audio/") == 0) {
                                        iconType = "audio"
                                    } else if (mimeType.indexOf("image/") == 0) {
                                        iconType = "image"
                                    } else if (mimeType.indexOf("video/") == 0) {
                                        iconType = "video"
                                    }
                                }
                                iconSource = "image://theme/icon-m-file-" + iconType
                            }
                            return iconSource + (highlighted ? "?" + Theme.highlightColor : "")
                        }
                    }
                }
                Column {
                    width: parent.width - parent.height - parent.spacing - Theme.horizontalPageMargin
                    anchors.verticalCenter: parent.verticalCenter
                    spacing: -Theme.paddingSmall
                    Label {
                        text: model.fileName
                        width: parent.width
                        font.pixelSize: Theme.fontSizeLarge
                        truncationMode: TruncationMode.Fade
                        color: highlighted ? Theme.highlightColor : Theme.primaryColor
                    }
                    Label {
                        property string dateString: Format.formatDate(model.modified, Formatter.DateLong)
                        text: model.isDir ? dateString
                                            //: Shows size and modification date, e.g. "15.5MB, 02/03/2016"
                                            //% "%1, %2"
                                          : qsTrId("filemanager-la-file_details").arg(Format.formatFileSize(model.size)).arg(dateString)
                        width: parent.width
                        truncationMode: TruncationMode.Fade
                        font.pixelSize: Theme.fontSizeSmall
                        color: highlighted ? Theme.secondaryHighlightColor : Theme.secondaryColor
                    }
                }
            }

            onClicked: {
                if (model.isDir) {
                    pageStack.push(Qt.resolvedUrl("FileManagerPage.qml"),
                                   { path: fileModel.appendPath(model.fileName), homePath: page.homePath, callback: page.callback })
                } else {
                    var filePath = fileModel.path + "/" + model.fileName;
                    console.log("###", mimeType, filePath);
                    //if (mimeType.indexOf("image/") == 0) {
                    if (typeof callback == "function") {
                        callback(filePath);
                    }
                    //}
                }
            }
        }
        ViewPlaceholder {
            enabled: fileModel.count === 0
            //% "No files"
            text: qsTrId("filemanager-la-no_files")
        }
        VerticalScrollDecorator {}
    }
    Python {
        id: py

        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./../python'));
            importModule('addFile', function() {});
        }
        onError: {
            showError(traceback)
            console.log('python error: ' + traceback);
        }
    }

    AddFileDialog {
        id: dialog
    }
}
