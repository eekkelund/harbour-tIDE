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
import org.nemomobile.notifications 1.0



Page {
    id: page
    property bool textChangedAutoSave: false
    property bool textChangedSave: false
    property string fileTitle: singleFile
    //Check if file ends with tilde "~" and change the filetype accordingly
    property string fileType: /~$/.test(fileTitle) ? fileTitle.split(".").slice(-1)[0].slice(0, -1) :fileTitle.split(".").slice(-1)[0];
    /*property var lineNumberslist: new Array()
    property int lastLineCount:0
    property int numLines:0
    property int lineCount: 1

    function numberOfLines() {
        console.log(myeditor._editor.lineCount)
        //while(myeditor._editor.lineCount >= lineCount) {
           //if(myeditor.text.match(/\n/g) || []){
                var lineBreakPosition
                for (var i = 1 ; i <= myeditor.text.length; i++)
                {
                    console.log(Math.round(myeditor.positionToRectangle(i).y/myeditor.positionToRectangle(i).height+1))
                    console.log(lineCount)
                    if (Math.round(myeditor.positionToRectangle(i).y/myeditor.positionToRectangle(i).height+1) > lineCount){
                        if (myeditor.text[i-1] === "\n"){
                            console.log("tämäpäs")
                            numLines =numLines+1
                            lineNumberslist.push(numLines)

                        }else{
                            console.log("tämdsäpäs")
                            lineNumberslist.push(" ")
                        }
                        lineCount=lineCount+1
                    }
                }

            //}
       // }

        //lineNumberslist += 1;
        //lineNumberslist=lastLineCount
        //console.log(lineNumberslist)
        //return lineNumberslist;
                lastLineCount=lineCount
    }

    function lineNumberChanged() {
        console.log(lastLineCount)
        console.log(myeditor._editor.lineCount)
        if (lastLineCount===lineCount){
        if (myeditor._editor.lineCount > lineNumberslist.length){//lastLineCount) {
            console.log("Last character = " + myeditor.text[myeditor.cursorPosition - 1])
            if(myeditor.text[myeditor.cursorPosition - 1] !== "\n") {
                //lineNumberslist += "\n"
                // += 1
                //lineNumberslist.push(" ")
                lineNumberslist.splice(myeditor.currentLine-1, 0, " ")
            }
            else {
                //lineNumberslist += numberOfLines() + "\n";
                // += " "
                numLines =numLines+1
                lineNumberslist.push(numLines)

            }
            lastLineCount = myeditor._editor.lineCount;
        } else if (myeditor._editor.lineCount < lineNumberslist.length){//lastLineCount) {
            //lineNumberslist = lineNumberslist.slice(0, -2);
            console.log("perkr")
            var popp = lineNumberslist.pop()
             console.log(lineNumberslist)
            if( popp !== " "){
                numLines =numLines-1
            }

            lastLineCount = myeditor._editor.lineCount;
        }
        lineCount = lastLineCount
        return lineNumberslist
        }
    }*/
    Rectangle {
        id:rectangle
        color: bgColor
        anchors.fill: parent
        visible: true

        Notification{
            id:notification
        }
        function showError(message) {
            notification.category="x-nemo.example"
            notification.previewBody = qsTr("Erororor");
            notification.close();
            notification.publish();
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
                        visible: true
                        MouseArea {
                            enabled: !flipable.flipped
                            onClicked: {
                                flipable.flipped = !flipable.flipped
                            }
                            anchors.fill: parent
                        }
                    }
                    back:Flow {
                        id:menu
                        height: pgHead.height
                        spacing: Theme.paddingMedium
                        //anchors.horizontalCenter: parent.horizontalCenter
                        SearchField{
                            id:searchField
                            width: activeFocus ? pgHead.width : implicitWidth
                            placeholderText: "Search"
                            EnterKey.onClicked: myeditor.text.search(searchField.text)
                        }

                        IconButton {
                            icon.source: "image://theme/icon-m-rotate-left"
                            enabled: myeditor._editor.canUndo
                            onClicked: myeditor._editor.undo()
                        }
                        IconButton {
                            icon.source: "image://theme/icon-m-rotate-right"
                            enabled: myeditor._editor.canRedo
                            onClicked: myeditor._editor.redo()
                        }
                        IconButton {
                            icon.source: "image://ownIcons/icon-m-save"
                            enabled: textChangedSave
                            onClicked: {
                                py.call('editFile.savings', [filePath,myeditor.text], function(result) {
                                    fileTitle=result
                                });
                                textChangedSave=false;
                            }

                        }
                        IconButton {
                            icon.source: "image://theme/icon-m-close"
                            onClicked:{
                                flipable.flipped = false
                            }
                        }
                    }

                }
            }
        }
        function search(){

        }

        SilicaFlickable {
            id:f
            clip: true
            anchors.top: hdr.bottom
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.right:parent.right
            contentHeight:  contentColumn.height
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
                        py.call('editFile.autosave', [filePath,myeditor.text], function(result) {
                            fileTitle=result
                            console.log(result)
                        });
                        textChangedAutoSave=false;
                    }
                }
            }

            onContentYChanged: {
                if (contentY-startY > 200 && time < 2 ) {
                    hdr.visible=false
                    f.anchors.top = rectangle.top

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
                    width: lineNums ? linecolumn.width *1.2 : 0
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

                        anchors.left: parent.left
                        anchors.right: parent.right
                        textMargin: 0
                        labelVisible: false
                        wrapMode: TextEdit.Wrap
                        text: documentHandler.text
                        color: focus ? textColor : Theme.primaryColor
                        font.pixelSize: fontSize
                        font.family: fontType
                        onClicked: console.log(text[cursorPosition - 1] + "-last-"+myeditor.positionToRectangle(myeditor.text.length)+"sdsa"+myeditor.positionToRectangle(myeditor.text.length).height)
                        /*ORIGINAL FUNCTION TAKEN FROM HERE: https://github.com/olegyadrov/qmlcreator/blob/master/qml/components/CCodeArea.qml#L143
                        *ORIGINAL LICENSE APACHE2 AND CREATOR Oleg Yadrov
                        *I HAVE MODIFIED ORIGINAL FUNCTION
                        *THANK YOU Oleg Yadrov :)
                        */
                        onTextChanged: {
                            if (text !== previousText)
                            {
                                //lineNumberChanged()
                                //console.log(lineNumberslist)
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
                                    textChangedSave = true
                                    var colonCount
                                    console.log(lastCharacter)
                                    console.log(text[cursorPosition])
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
                                                cPosition =cursorPosition+indentStr.length
                                                textBeforeCursor = text.substring(0, cursorPosition)
                                                textAfterCursor = text.substring(cursorPosition, text.length)
                                                myeditor.text = textBeforeCursor + indentStr + textAfterCursor
                                                cursorPosition = cPosition
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
                                                    /*cPosition =cursorPosition+indentStringCount
                                                    console.log(cPosition+"and"+cursorPosition)
                                                    textBeforeCursor = text.substring(0, cursorPosition)
                                                    textAfterCursor = text.substring(cursorPosition, text.length)
                                                    myeditor.text = textBeforeCursor + indentStr+ textAfterCursor
                                                    cursorPosition = cPosition
                                                    console.log(cursorPosition)*/

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
                                        console.log(lineBreakPosition);

                                        if (lineBreakPosition !== undefined)
                                        {
                                            textChangedManually = true

                                            _editor.remove(lineBreakPosition + 1, cursorPosition - 1)
                                            //will remove empty spaces*indentDepth
                                            /*cPosition =lineBreakPosition + 1
                                            textBeforeCursor=text.substring(0, lineBreakPosition + 1)
                                            textAfterCursor=text.substring(cursorPosition - 1, text.length)
                                            text = textBeforeCursor + textAfterCursor
                                            cursorPosition = cPosition*/
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
                                                    //indentStringCount = indentStr.length
                                                    textChangedManually = true
                                                    /*cPosition =cursorPosition+indentStringCount
                                                    console.log(cPosition+"and,"+cursorPosition)
                                                    textBeforeCursor = text.substring(0, cursorPosition)
                                                    textAfterCursor = text.substring(cursorPosition, text.length)
                                                    myeditor.text = textBeforeCursor + indentStr + textAfterCursor
                                                    cursorPosition = cPosition+1
                                                    console.log(cursorPosition)*/
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
                console.log(fileType);
                addImportPath(Qt.resolvedUrl('./../python'));
                importModule('editFile', function () {});
            }
            onError: {
                // when an exception is raised, this error handler will be called
                console.log('python error: ' + traceback);
                showError();

            }
            onReceived: console.log('Unhandled event: ' + data)
        }
    }
    onStatusChanged:{
        if((status !== PageStatus.Active) || (myeditor.text.length > 0)){
            return;
        }
        else {
            console.log(filePath)
            documentHandler.setStyle(propertiesHighlightColor, stringHighlightColor,
                                     qmlHighlightColor, javascriptHighlightColor,
                                     commentHighlightColor, keywordsHighlightColor,
                                     myeditor.font.pixelSize);
            py.call('editFile.checkAutoSaved', [filePath], function(result) {
                if(!result){
                    py.call('editFile.openings', [filePath], function(result) {
                        documentHandler.text = result.text;
                        fileTitle=result.fileTitle
                        py.call('editFile.changeFiletype', [fileType], function(result){});
                        documentHandler.setDictionary(fileType);
                    })
                }else {
                    pageStack.push(restoreD);
                }
            })
            myeditor.forceActiveFocus();
            busy.running=false;
            //numberOfLines()//
            //console.log(lineNumberslist)
        }
    }
    RestoreDialog{
        id:restoreD
    }
}
