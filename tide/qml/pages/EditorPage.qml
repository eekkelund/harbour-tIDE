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
import harbour.tide.documenthandler 1.0
import harbour.tide.keyboardshortcut 1.0

Page {
    id: page
    objectName: "editorPage"
    property bool textChangedAutoSave: false
    property bool textChangedSave: false
    property bool searched: false
    property bool shortcutUsed: false
    property bool ready: false
    property string fileTitle: singleFile
    property string fullFilePath
    property string previousPath:fullFilePath.replace(fileTitle, "")
    property bool inSplitView: false
    //Check if file ends with tilde "~" and change the filetype accordingly
    property string fileType: /~$/.test(fileTitle) ? fileTitle.split(".").slice(-1)[0].slice(0, -1) :fileTitle.split(".").slice(-1)[0];
    property alias background: background
    property alias myeditor: myeditor
    property alias drawer:drawer
    property alias restoreD:restoreD

    function searchActive(){
        if (!flipable.flipped){
            flipable.flipped = true
        }
        searchField.forceActiveFocus()
    }

    function pageStatusChange(page){
        if((page.status !== PageStatus.Active) || (myeditor.text.length > 0)){
            if (autoSave&&textChangedAutoSave){
                py.call('editFile.savings', [fullFilePath,myeditor.text], function(result) {
                    fileTitle=result
                });
            }
            ready =false
            return;
        }
        else {
            documentHandler.setStyle(propertiesHighlightColor, stringHighlightColor,
                                     qmlHighlightColor, javascriptHighlightColor,
                                     commentHighlightColor, keywordsHighlightColor,
                                     myeditor.font.pixelSize);
            py.call('editFile.checkAutoSaved', [fullFilePath], function(result) {
                if(!result){
                    py.call('editFile.openings', [fullFilePath], function(result) {
                        documentHandler.text = result.text;
                        fileTitle=result.fileTitle
                        py.call('editFile.changeFiletype', [fileType], function(result){});
                        documentHandler.setDictionary(fileType);
                    })
                }else {
                    pageStack.push(restoreD, {pathToFile:fullFilePath});
                }
            })
            myeditor.forceActiveFocus();
            busy.running=false;
            if(hint<3){
                headerHint.start()
                hint = hint+1
            }
        }
        ready = true
    }

    Drawer {
        id: drawer

        anchors.fill: parent
        dock: Dock.Left

        background: SilicaListView {
            anchors.fill: parent
            model: ListModel{
                id: lmodel
                function loadNew(path) {
                    clear()
                    py.call('openFile.allfiles', [path], function(result) {
                        for (var i=0; i<result.length; i++) {
                            lmodel.append(result[i]);
                        }
                    });
                }
            }

            header: PageHeader {
                title: qsTr("Open file")
            }
            VerticalScrollDecorator {}

            delegate: ListItem {
                property string path: pathh
                id: litem
                width: parent.width
                height: Theme.itemSizeSmall
                anchors {
                    left: parent.left
                    right: parent.right
                }
                onClicked: {
                    if (file.text.slice(-1) =="/") {
                        lmodel.loadNew(path);
                    }else {
                        fullFilePath=path
                        py.call('editFile.checkAutoSaved', [fullFilePath], function(result) {
                            if(!result){
                                console.log(fullFilePath+" "+ path)
                                py.call('editFile.openings', [fullFilePath], function(result) {
                                    fileTitle=result.fileTitle
                                    documentHandler.text = result.text;
                                    fileType= /~$/.test(fileTitle) ? fileTitle.split(".").slice(-1)[0].slice(0, -1) :fileTitle.split(".").slice(-1)[0];
                                    previousPath=fullFilePath.replace(fileTitle, "")
                                    py.call('editFile.changeFiletype', [fileType], function(result){});
                                    documentHandler.setDictionary(fileType);
                                })
                            }else {
                                pageStack.push(restoreD, {pathToFile:path});
                            }
                        })
                        myeditor.forceActiveFocus();
                    }

                }
                Label {
                    id: file
                    wrapMode: Text.WordWrap
                    width: parent.width
                    anchors.verticalCenter: parent.verticalCenter
                    x: Theme.paddingMedium
                    text: files

                }
            }
        }

        Rectangle {
            id:background
            color: bgColor
            anchors.fill: parent
            visible: true

            MouseArea {
                enabled: drawer.open
                anchors.fill: parent
                onClicked: drawer.open = false
            }

            BusyIndicator {
                id:busy
                size: BusyIndicatorSize.Large
                anchors.centerIn: parent
                running: true
            }

            SilicaFlickable {
                id:hdr
                anchors.top:parent.top
                height: headerColumn.height
                width: parent.width
                enabled: !drawer.opened

                TouchInteractionHint{
                    id: headerHint
                    z: 999
                    direction: TouchInteraction.Up
                    anchors.horizontalCenter: parent.horizontalCenter
                    distance: 1
                    loops: 2
                }
                InteractionHintLabel {
                    text: qsTr("Tap to show top bar")
                    opacity: headerHint.running ? 1.0 : 0.0
                    Behavior on opacity { FadeAnimation {} }
                    width: parent.width
                    anchors.top: parent.bottom
                    invert: true
                }

                Column {
                    id:headerColumn
                    width: parent.width
                    spacing: Theme.paddingSmall
                    height: pgHead.height
                    Flipable {
                        id: flipable
                        width: parent.width
                        height: parent.height

                        property bool flipped: false

                        function search(text, position, direction) {
                            //var reg = new RegExp(text, "ig")
                            text= text.toLowerCase()
                            var myText = myeditor.text.toLowerCase()
                            Theme.highlightText(myText,text,Theme.highlightColor)
                            //var match = myeditor.text.match(reg)
                            var match = myText.match(text)
                            if(match){
                                if(direction=="back"){
                                    myeditor.cursorPosition = myText.lastIndexOf(match[match.length-1], position)
                                    if(myText.lastIndexOf(match[match.length-1], position) != -1) myeditor.select(myeditor.cursorPosition,myeditor.cursorPosition+text.length)
                                }else{
                                    myeditor.cursorPosition = myText.indexOf(match[0],position)
                                    if (myText.indexOf(match[0],position)!=-1) myeditor.select(myeditor.cursorPosition,myeditor.cursorPosition+text.length)
                                }
                            }else{
                                searchField.errorHighlight = true
                            }
                        }

                        transform: Rotation {
                            id: rotation
                            origin.x: flipable.width/2
                            origin.y: flipable.height/2
                            axis.x: -1; axis.y: 0; axis.z: 0     // set axis.y to 1 to rotate around y-axis
                            angle: 0    // the default angle
                        }

                        states: State {
                            name: "back"
                            PropertyChanges { target: rotation; angle: 180 }
                            when: flipable.flipped
                        }

                        transitions: Transition {
                            NumberAnimation { target: rotation; property: "angle"; duration: 300 }
                        }

                        front:PageHeader  {
                            id:pgHead
                            width: parent.width
                            anchors.right:parent.right
                            title: fileTitle
                            visible: !flipable.flipped
                            enabled: visible
                            MouseArea {
                                enabled: !flipable.flipped
                                onClicked: {
                                    flipable.flipped = !flipable.flipped
                                }
                                anchors.fill: parent
                            }
                        }

                        back: Item{
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                            width: parent.width
                            height: parent.height
                            clip:true
                            Flickable {
                                id: topBarFlick
                                anchors.fill: parent
                                contentWidth: menu.width < parent.width ? parent.width:menu.width
                                contentHeight: menu.height
                                contentX: topBarFlick.contentWidth/2-parent.width/2
                                Flow {
                                    id:menu
                                    height: pgHead.height
                                    anchors.horizontalCenter: parent.horizontalCenter

                                    SearchField{
                                        id:searchField
                                        width: (activeFocus || text.length>0) ? pgHead.width -previous.width*2: implicitWidth
                                        placeholderText: qsTr("Search")
                                        EnterKey.onClicked:{
                                            flipable.search(text,myeditor.cursorPosition,"forward");
                                            searched=true
                                        }
                                        onTextChanged: {
                                            if(shortcutUsed){
                                                shortcutUsed=false
                                                if(searchField.text[searchField.cursorPosition - 1] === "f"|| searchField.text[searchField.cursorPosition - 1] === "F"){
                                                    searchField._editor.remove(searchField.cursorPosition - 1, searchField.cursorPosition)
                                                }
                                            }
                                            errorHighlight = false
                                            searched = false
                                        }
                                    }

                                    IconButton {
                                        id:previous
                                        icon.source: "image://theme/icon-m-previous"
                                        enabled: searched
                                        onClicked:{
                                            flipable.search(searchField.text,myeditor.cursorPosition-searchField.text.length-1,"back");
                                        }
                                        visible:searchField.activeFocus || searchField.text.length>0
                                    }
                                    IconButton {
                                        id:next
                                        icon.source: "image://theme/icon-m-next"
                                        enabled: searched
                                        onClicked:{
                                            flipable.search(searchField.text,myeditor.cursorPosition-(searchField.text.length-1),"forward");
                                        }
                                        visible:searchField.activeFocus || searchField.text.length>0
                                    }
                                    IconButton {
                                        icon.source: "image://theme/icon-m-rotate-left"
                                        enabled: myeditor._editor.canUndo
                                        onClicked: myeditor._editor.undo()
                                        visible:!searchField.activeFocus && searchField.text.length<=0
                                    }
                                    IconButton {
                                        icon.source: "image://theme/icon-m-rotate-right"
                                        enabled: myeditor._editor.canRedo
                                        onClicked: myeditor._editor.redo()
                                        visible:!searchField.activeFocus && searchField.text.length<=0
                                    }
                                    IconButton {
                                        icon.source: "image://ownIcons/icon-m-save"
                                        enabled: textChangedSave
                                        visible:!searchField.activeFocus && searchField.text.length<=0
                                        onClicked: {
                                            py.call('editFile.savings', [fullFilePath,myeditor.text], function(result) {
                                                fileTitle=result
                                            });
                                            textChangedSave=false;
                                        }
                                    }
                                    IconButton {
                                        icon.source: "image://theme/icon-m-folder"
                                        visible:!searchField.activeFocus && searchField.text.length<=0
                                        enabled: !drawer.opened && !textChangedSave
                                        onClicked:{
                                            lmodel.loadNew(previousPath)
                                            drawer.open = true
                                        }
                                    }
                                    IconButton {
                                        icon.source: "image://theme/icon-m-flip"
                                        visible: !inSplitView && Screen.sizeCategory === Screen.Large && !searchField.activeFocus && searchField.text.length<=0
                                        enabled: visible && !textChangedSave
                                        onClicked:{
                                            pageStack.replace(Qt.resolvedUrl("SplitPage.qml"),{fullFilePath: fullFilePath},PageStackAction.Immediate)
                                        }
                                    }
                                    IconButton {
                                        icon.source: "image://theme/icon-m-close"
                                        visible:!searchField.activeFocus && searchField.text.length<=0
                                        onClicked:{
                                            flipable.flipped = false
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            SilicaFlickable {
                id:f
                clip: true
                anchors.top: hdr.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                anchors.right:parent.right
                contentHeight:  contentColumn.height
                enabled: !drawer.opened
                property int time
                property int startY
                VerticalScrollDecorator {}
                onMovementStarted: {
                    startY = contentY
                    time = 0
                    timeri.restart()
                }
                Timer {
                    id:timeri
                    interval: 500;
                    repeat:true;
                    onTriggered: {
                        f.time = f.time +1
                    }
                }

                Timer {
                    id:autosaveTimer
                    interval: 3000;
                    running: autoSave;
                    repeat: autoSave;
                    onTriggered: {
                        if(textChangedAutoSave){
                            py.call('editFile.autosave', [fullFilePath,myeditor.text], function(result) {
                                fileTitle=result
                                previousPath=fullFilePath.replace(fileTitle.slice(0, -1), "")
                            });
                            textChangedAutoSave=false;
                        }
                    }
                }

                onContentYChanged: {
                    if (contentY-startY > 200 && time < 2 ) {
                        hdr.visible=false
                        f.anchors.top = background.top

                    }
                    if (startY-contentY > 200 && time < 2 ) {
                        hdr.visible=true
                        f.anchors.top = hdr.bottom

                    }
                    if (contentY<100){
                        hdr.visible=true
                        f.anchors.top = hdr.bottom
                    }
                }

                Item {
                    id:all
                    anchors.fill: parent

                    Rectangle {
                        id: linenum
                        anchors.top: parent.top
                        anchors.bottom: parent.bottom
                        anchors.left: parent.left
                        width: lineNums ? linecolumn.width *1.2 : Theme.paddingSmall
                        color: "transparent"
                        visible: lineNums
                        Column {
                            id: linecolumn
                            y: Theme.paddingSmall
                            anchors.horizontalCenter: parent.horizontalCenter

                            Repeater {
                                id:repeat
                                model: myeditor._editor.lineCount
                                delegate: TextEdit {
                                    anchors.right: linecolumn.right
                                    color: index + 1 === myeditor.currentLine ? Theme.primaryColor : Theme.secondaryColor
                                    readOnly:true
                                    font.pixelSize: myeditor.font.pixelSize
                                    text: index+1//lineNumberslist[index]
                                }
                            }
                        }
                    }
                    Column {
                        id: contentColumn
                        anchors.top: parent.top
                        anchors.left: linenum.right
                        anchors.right: parent.right

                        TextArea {
                            id: myeditor
                            property string previousText: ""
                            property bool textChangedManually: false
                            property int currentLine: myeditor.positionToRectangle(cursorPosition).y/myeditor.positionToRectangle(cursorPosition).height +1
                            property bool modified: false
                            property string path

                            width: background.width -parent.x
                            textMargin: 0
                            labelVisible: false
                            wrapMode: appWindow.wrapMode
                            text: documentHandler.text
                            color: focus ? textColor : Theme.primaryColor
                            font.pixelSize: fontSize
                            font.family: fontType
                            textWidth: wrapMode !== Text.NoWrap ? width : Math.max(width, editor.implicitWidth)
                            _flickableDirection: Flickable.HorizontalAndVerticalFlick

                            KeyboardShortcut {
                                key: "Ctrl+F"
                                onActivated: {
                                    if(myeditor.focus){
                                        shortcutUsed=true
                                        searchActive()
                                    }
                                }
                            }
                            KeyboardShortcut {
                                key: "Ctrl+S"
                                onActivated: {
                                    if(myeditor.focus){
                                        shortcutUsed=true
                                        py.call('editFile.savings', [fullFilePath,myeditor.text], function(result) {
                                            fileTitle=result
                                            textChangedSave=false;
                                        });
                                    }
                                }
                            }

                            /*ORIGINAL FUNCTION TAKEN FROM HERE: https://github.com/olegyadrov/qmlcreator/blob/master/qml/components/CCodeArea.qml#L143
                        *ORIGINAL LICENSE APACHE2 AND CREATOR Oleg Yadrov
                        *I HAVE MODIFIED ORIGINAL FUNCTION
                        */
                            onTextChanged: {
                                if(shortcutUsed&&myeditor.focus){
                                    shortcutUsed=false
                                    if(myeditor.text[myeditor.cursorPosition - 1] === "s"|| myeditor.text[myeditor.cursorPosition - 1] === "S"){
                                        myeditor._editor.remove(myeditor.cursorPosition - 1, myeditor.cursorPosition)
                                    }
                                }
                                if (text !== previousText)
                                {
                                    textChangedSave = true
                                    //lineNumberChanged()
                                    if (textChangedManually)
                                    {
                                        previousText = text
                                        textChangedManually = false
                                        return
                                    }

                                    if (myeditor.text.length > previousText.length)
                                    {
                                        var textBeforeCursor
                                        var textAfterCursor
                                        var openBrackets
                                        var closeBrackets
                                        var openBracketsCount
                                        var closeBracketsCount
                                        var indentDepth
                                        var indentStr
                                        var cPosition
                                        var txti
                                        var txti2
                                        var indentStringCount
                                        var lastCharacter = text[cursorPosition - 1]
                                        var colonCount
                                        switch (lastCharacter)
                                        {

                                        case "\n":
                                            textChangedAutoSave=true;
                                            f.startY = f.contentY
                                            textBeforeCursor = text.substring(0, cursorPosition - 1)

                                            if(fileType=="py"){
                                                if(text[cursorPosition - 2]===":"){
                                                    colonCount = textBeforeCursor.match(/\:/g).length
                                                    indentStr = new Array(colonCount).join("    ")
                                                    _editor.insert(cursorPosition - 1, indentStr)
                                                    break
                                                }
                                            }else if(indentSize<0){
                                                break
                                            }else{

                                                openBrackets = textBeforeCursor.match(/\{/g)
                                                closeBrackets = textBeforeCursor.match(/\}/g)

                                                if (openBrackets !== null)
                                                {
                                                    openBracketsCount = openBrackets.length
                                                    closeBracketsCount = 0

                                                    if (closeBrackets !== null)
                                                        closeBracketsCount = closeBrackets.length

                                                    indentDepth = openBracketsCount - closeBracketsCount
                                                    if (indentDepth > 0){
                                                        indentStr = new Array(indentDepth + 1).join(indentString)
                                                        indentStringCount = indentStr.length

                                                        textChangedManually = true
                                                        _editor.insert(cursorPosition, indentStr)
                                                    }
                                                }
                                            }
                                            break
                                        case "}":
                                            //bug fix with letters after "}"
                                            if (/^[a-zA-Z]/.test(text[cursorPosition])){
                                                break
                                            }

                                            var lineBreakPosition
                                            for (var i = cursorPosition - 2; i >= 0; i--)
                                            {
                                                if (text[i] !== " ")
                                                {
                                                    if (text[i] === "\n")
                                                        lineBreakPosition = i

                                                    break
                                                }
                                            }
                                            if (lineBreakPosition !== undefined)
                                            {
                                                textChangedManually = true

                                                _editor.remove(lineBreakPosition + 1, cursorPosition - 1)
                                                //will remove empty spaces*indentDepth
                                                textBeforeCursor = text.substring(0, cursorPosition-1)
                                                openBrackets = textBeforeCursor.match(/\{/g)
                                                closeBrackets = textBeforeCursor.match(/\}/g)

                                                if (openBrackets !== null)
                                                {

                                                    openBracketsCount = openBrackets.length
                                                    closeBracketsCount = 0

                                                    if (closeBrackets !== null)
                                                        closeBracketsCount = closeBrackets.length

                                                    indentDepth = openBracketsCount - closeBracketsCount -1

                                                    if (indentDepth >= 0){
                                                        indentStr = new Array(indentDepth + 1).join(indentString)
                                                        textChangedManually = true
                                                        _editor.insert(cursorPosition - 1, indentStr)
                                                    }
                                                }
                                            }
                                            break
                                        }
                                    }
                                    previousText = text
                                }
                            }

                            DocumentHandler {
                                id: documentHandler
                                target: myeditor._editor
                                cursorPosition: myeditor.cursorPosition
                                selectionStart: myeditor.selectionStart
                                selectionEnd: myeditor.selectionEnd
                                onTextChanged: {
                                    myeditor.text = text
                                    myeditor.update()
                                }
                            }
                        }
                    }
                }
            }
            Python {
                id: py

                Component.onCompleted: {
                    addImportPath(Qt.resolvedUrl('./../python'));
                    importModule('editFile', function () {});
                }
                onError: {
                    showError(traceback)
                    // when an exception is raised, this error handler will be called
                    console.log('python error: ' + traceback);

                }
            }
        }
    }
    onStatusChanged:{
        pageStatusChange(page)
    }

    RestoreDialog{
        id:restoreD
    }
}
