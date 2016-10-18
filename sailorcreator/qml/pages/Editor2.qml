import QtQuick 2.0
import Sailfish.Silica 1.0
import io.thp.pyotherside 1.3
import eekkelund.documenthandler 1.0


Page {
    id: page
    //VerticalScrollDecorator{flickable:f}
    allowedOrientations: Orientation.All
    property string fileTitle
    BusyIndicator {
        id:busy
        size: BusyIndicatorSize.Large
        anchors.centerIn: parent
        running: true

    }

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
                title: fileTitle
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

        onContentYChanged: {

            console.debug(contentY)
            console.debug(time)

            if (contentY-startY > 200 && time < 2 ) {
                hdr.visible=false
                f.anchors.top = page.top

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
                width: linecolumn.width *1.2
                //color:Theme.highlightBackgroundColor
                color: "transparent"


                Column {
                    id: linecolumn
                    y: Theme.paddingSmall
                    anchors.horizontalCenter: parent.horizontalCenter

                    Repeater {
                        id:repeat
                        model: nullEdit.lineCount
                        //model: myeditor.positionToRectangle(myeditor.text.length)/myeditor.positionToRectangle(myeditor.text.length).height +1
                        delegate: TextEdit {
                            anchors.right: linecolumn.right
                            color: index + 1 === myeditor.currentLine ? Theme.primaryColor : Theme.secondaryColor
                            readOnly:true
                            font.pixelSize: myeditor.font.pixelSize
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
                    labelVisible: false
                    //objectName: "myeditor"
                    wrapMode: TextEdit.Wrap//Text.WordWrap

                    //anchors.top: parent.top
                    //width: parent.width
                    text: documentHandler.text
                    //color: Theme.primaryColor
                    font.pixelSize: Theme.fontSizeSmall
                    //visible:false
                    onClicked: console.log(text[cursorPosition - 1] + "-last-"+myeditor.positionToRectangle(myeditor.text.length)+"sdsa"+myeditor.positionToRectangle(myeditor.text.length).height)
                    /*Component.onCompleted: {
                        //var txt;
                        py.call('editFile.openings', [filePath], function(result) {
                            //myeditor.text = result;
                            documentHandler.text=result;
                        });
                        //var txt = myeditor.text;
                        //documentHandler.text = txt;
                       // myeditor.modified = false;
                        myeditor.forceActiveFocus();

                    }*/
                    onTextChanged: {
                        /*if (focus) {
                            console.debug("onTextChanged")
                            myeditor.modified = true;
                            // nullEdit.text = myeditor.text;
                        }*/


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
                                var textAfterCursor
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
                                console.log(lastCharacter)
                                console.log(text[cursorPosition])
                                switch (lastCharacter)
                                {
                                case "\n":
                                    f.startY = f.contentY
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
                                            textBeforeCursor = text.substring(0, cursorPosition)
                                            textAfterCursor = text.substring(cursorPosition, text.length)
                                            myeditor.text = textBeforeCursor + indentString+ textAfterCursor
                                            cursorPosition = cPosition
                                            console.log(cursorPosition)

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
                                        //cPosition=cursorPosition
                                        cPosition =lineBreakPosition + 1
                                        textBeforeCursor=text.substring(0, lineBreakPosition + 1)
                                        textAfterCursor=text.substring(cursorPosition - 1, text.length)
                                        text = textBeforeCursor + textAfterCursor
                                        //cut()
                                        cursorPosition = cPosition

                                        //remove(lineBreakPosition + 1, cursorPosition - 1)

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
                                                indentString = new Array(indentDepth + 1).join(myeditor.indentString)
                                                indentStringCount = indentString.length





                                                textChangedManually = true

                                                cPosition =cursorPosition+indentStringCount
                                                console.log(cPosition+"and,"+cursorPosition)
                                                //myeditor.select(0,cursorPosition);


                                                //txti = myeditor.selectedText//KÄYTÄ TÄTÄ textBeforeCursor = text.substring(0, cursorPosition)
                                                //myeditor.select(cursorPosition,myeditor.text.length);
                                                //txti2= myeditor.selectedText
                                                textBeforeCursor = text.substring(0, cursorPosition)
                                                textAfterCursor = text.substring(cursorPosition, text.length)

                                                //console.log(cPosition+"and22,"+cursorPosition)
                                                //myeditor.deselect()
                                                myeditor.text = textBeforeCursor + indentString + textAfterCursor
                                                cursorPosition = cPosition+1
                                                console.log(cursorPosition)
                                                //insert(cursorPosition - 1, indentString)
                                            }
                                            //if (indentStringCount == null) {
                                            //  indentStringCount =0
                                            //}



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
                        /*Component.onCompleted: {
                            //var txt;
                            documentHandler.setStyle(Theme.primaryColor, Theme.secondaryColor,
                                                     Theme.highlightColor, Theme.secondaryHighlightColor,
                                                     Theme.highlightBackgroundColor, Theme.highlightDimmerColor,
                                                     myeditor.font.pixelSize);
                            py.call('editFile.openings', [filePath], function(result) {
                                //myeditor.text = result;
                                documentHandler.text = result;
                            });
                            //var txt = myeditor.text;
                            //documentHandler.text = txt;
                            //myeditor.modified = false;

                            myeditor.forceActiveFocus();

                        }*/
                        onTextChanged: {
                            myeditor.update()
                        }

                    }

                }
                TextEdit {

                    id: nullEdit
                    color: "white"
                    font.pixelSize: myeditor.font.pixelSize
                    wrapMode: myeditor.wrapMode//Text.WordWrap
                    anchors.left: myeditor.left
                    anchors.right: myeditor.right
                    //width: 2
                    text: myeditor.text
                    visible: false

                }
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
    onStatusChanged:{
        if((status !== PageStatus.Active) || (myeditor.text.length > 0)){
            return;
        }
        else {
            //busy.running=true;
            documentHandler.setStyle(Theme.primaryColor, Theme.secondaryColor,
                                     Theme.highlightColor, Theme.secondaryHighlightColor,
                                     Theme.highlightBackgroundColor, Theme.highlightDimmerColor,
                                     myeditor.font.pixelSize);
            py.call('editFile.openings', [filePath], function(result) {
                //myeditor.text = result;
                documentHandler.text = result;
            });
            myeditor.forceActiveFocus();
            busy.running=false;
        }
    }
}


