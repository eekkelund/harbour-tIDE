import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.4
import eekkelund.documenthandler 1.0


Page {
    id: page
    //VerticalScrollDecorator{flickable:f}
    allowedOrientations: Orientation.All
    SilicaFlickable {
        id:hdr

        //anchors.left: parent.left
        //anchors.right:parent.right
        anchors.top:parent.top
        height: headerColumn.height
        width: parent.width

        PullDownMenu {
            MenuItem {
                text: "Save file"
                onClicked: py.call('editFile.savings', [filePath,myeditor.text], function(result) {});
            }
        }
        Column {
            id:headerColumn
            width: parent.width
            spacing: Theme.paddingSmall
            //height: pgHead.height
            PageHeader  {
                id:pgHead
                width: parent.width
                title: qsTr("TITLE")
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
        // anchors.fill: parent

        contentHeight:  contentColumn.height //+ headerColumn.height
        //contentWidth: f.width

        VerticalScrollDecorator {}
        /*Column {
            id:headerColumn
            width: parent.width
            spacing: Theme.paddingMedium
            PageHeader  {
                width: parent.width
                title: qsTr("TITLE")
            }
        }*/

        Item {
            id:all
            anchors.fill: parent
            //anchors.top:parent.top
            //anchors.top: hdr.bottom
            //anchors.bottom: parent.bottom
            //anchors.left: parent.left
            //anchors.right:parent.right
            //width: parent.width

            property int indentSize: 4

            onIndentSizeChanged: {
                var indentString = ""
                for (var i = 0; i < indentSize; i++)
                    indentString += " "
                myeditor.indentString = indentString
            }


            Rectangle {
                id: linenum
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                anchors.left: parent.left
                width: linecolumn.width *1.4
                color:Theme.highlightBackgroundColor

                Column {
                    id: linecolumn
                    y: Theme.paddingSmall
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        id:repeat
                        model: nullEdit.lineCount
                        delegate: Text {
                            anchors.right: linecolumn.right
                            color: index + 1 === myeditor.currentLine ? Theme.primaryColor : Theme.secondaryColor
                            //font.family: settings.font
                            font.pixelSize: Theme.fontSizeSmall
                            //font.bold: index + 1 === myeditor.currentLine
                            text: index + 1
                        }
                    }
                }
            }

            Column {
                id: contentColumn
                anchors.top: parent.top
                anchors.left: linenum.right
                anchors.right: parent.right
                //spacing: 5



                TextArea {

                    property string previousText: ""
                    property bool textChangedManually: false
                    property string indentString: "    "
                    property int currentLine: myeditor.positionToRectangle(cursorPosition).y/myeditor.positionToRectangle(cursorPosition).height +1
                    id: myeditor
                    property bool modified: false
                    property string path
                    anchors.left: parent.left
                    anchors.right: parent.right
                    textMargin: 0
                    //objectName: "myeditor"
                    wrapMode: TextEdit.Wrap//Text.WordWrap

                    //anchors.top: parent.top
                    //width: parent.width
                    text: documentHandler.text
                    //color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    //visible:false
                    onClicked: console.log(myeditor.positionToRectangle(cursorPosition).y+"sdsa"+myeditor.positionToRectangle(cursorPosition).height)
                    Component.onCompleted: {
                        py.call('editFile.openings', [filePath], function(result) {
                            myeditor.text = result;
                        });
                        var txt = myeditor.text;//pyNotes.loadNote(textEditor.path);
                        documentHandler.text = txt;
                        myeditor.modified = false;
                        myeditor.forceActiveFocus();

                    }
                    onTextChanged: {
                        if (focus) {
                            console.debug("onTextChanged")
                            myeditor.modified = true;
                           // nullEdit.text = myeditor.text;
                        }


                        // This is kind of stupid workaround, we forced to do this check because TextEdit sends
                        // us "textChanged" and "lengthChanged" signals after every select() and forceActiveFocus() call
                        if (text !== previousText)
                        {
                            if (textChangedManually)
                            {
                                previousText = text
                                textChangedManually = false
                                return
                            }

                            if (myeditor.text.length > previousText.length)
                            {
                                var textBeforeCursor
                                var openBrackets
                                var closeBrackets
                                var openBracketsCount
                                var closeBracketsCount
                                var indentDepth
                                var indentString
                                var cPosition
                                var txti
                                var txti2
                                var indentStringCount

                                var lastCharacter = text[cursorPosition - 1]

                                switch (lastCharacter)
                                {
                                case "\n":
                                    textBeforeCursor = text.substring(0, cursorPosition - 1)
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
                                            indentString = new Array(indentDepth + 1).join(myeditor.indentString)
                                            indentStringCount = indentString.length


                                            textChangedManually = true


                                            cPosition =cursorPosition+indentStringCount
                                            console.log(cPosition+"and"+cursorPosition)
                                            myeditor.select(0,cursorPosition);
                                            txti = myeditor.selectedText
                                            myeditor.select(cursorPosition,myeditor.text.length);
                                            txti2= myeditor.selectedText


                                            myeditor.deselect()
                                            myeditor.text = txti + indentString+ txti2
                                            cursorPosition = cPosition
                                            console.log(cursorPosition)

                                        }




                                    }
                                    break
                                /*case "}":
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
                                        //cPosition=cursorPosition
                                        //myeditor.select(lineBreakPosition + 1, cursorPosition - 1)
                                        //cut()
                                        //cursorPosition = cPosition

                                        //remove(lineBreakPosition + 1, cursorPosition - 1)

                                        textBeforeCursor = text.substring(0, cursorPosition)
                                        openBrackets = textBeforeCursor.match(/\{/g)
                                        closeBrackets = textBeforeCursor.match(/\}/g)

                                        if (openBrackets !== null)
                                        {

                                            openBracketsCount = openBrackets.length
                                            closeBracketsCount = 0

                                            if (closeBrackets !== null)
                                                closeBracketsCount = closeBrackets.length

                                            indentDepth = openBracketsCount - closeBracketsCount - 1
                                            console.log(indentDepth)
                                            if (indentDepth >= 0){
                                                indentString = new Array(indentDepth + 1).join(myeditor.indentString)
                                                indentStringCount = indentString.length


                                                console.log(indentStringCount)

                                                textChangedManually = true

                                                cPosition =cursorPosition+indentStringCount+1
                                                console.log(cPosition+"and,"+cursorPosition)
                                                myeditor.select(0,cursorPosition);
                                                txti = myeditor.selectedText//KÄYTÄ TÄTÄ textBeforeCursor = text.substring(0, cursorPosition)
                                                myeditor.select(cursorPosition,myeditor.text.length);
                                                txti2= myeditor.selectedText

                                                //console.log(cPosition+"and22,"+cursorPosition)
                                                myeditor.deselect()
                                                myeditor.text = txti + indentString + txti2
                                                cursorPosition = cPosition
                                                console.log(cursorPosition)
                                                //insert(cursorPosition - 1, indentString)
                                            }
                                            //if (indentStringCount == null) {
                                              //  indentStringCount =0
                                            //}



                                        }
                                    }

                                    break*/
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
                        Component.onCompleted: {
                            py.call('editFile.openings', [filePath], function(result) {
                                myeditor.text = result;
                            });
                            documentHandler.setStyle(Theme.primaryColor, Theme.secondaryColor,
                                                     Theme.highlightColor, Theme.secondaryHighlightColor,
                                                     myeditor.font.pixelSize);

                            var txt = myeditor.text;//pyNotes.loadNote(textEditor.path);
                            documentHandler.text = txt;
                            myeditor.modified = false;

                            myeditor.forceActiveFocus();

                        }
                        onTextChanged: {
                            myeditor.update()
                        }

                    }

                }
                TextEdit {

                    id: nullEdit
                    color: "white"
                    font.pixelSize: Theme.fontSizeSmall
                    wrapMode: TextEdit.Wrap//Text.WordWrap
                    anchors.left: myeditor.left
                    anchors.right: myeditor.right
                    //width: 2
                    text: myeditor.text
                    visible: false

                }
                //Dirty way to get linenumbering working :)
                /*Timer {
                    interval: 100
                    onTriggered: {
                        nullEdit.text = nullEdit.text + "\n";
                        stop();
                    }
                    Component.onCompleted: start()
                }*/

            }
        }
        Python {
            id: py

            Component.onCompleted: {
                addImportPath(Qt.resolvedUrl('./python'));
                importModule('editFile', function () {

                });

            }
            onError: {
                // when an exception is raised, this error handler will be called
                console.log('python error: ' + traceback);
            }
            onReceived: console.log('Unhandled event: ' + data)
        }
    }
}


