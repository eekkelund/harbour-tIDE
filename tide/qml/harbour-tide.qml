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
import org.nemomobile.notifications 1.0
import "pages"


ApplicationWindow
{
    id: appWindow
    initialPage: Component { MainPage {
            id:home
        } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: defaultAllowedOrientations
    _defaultPageOrientations: defaultAllowedOrientations

    property string homePath: StandardPaths.home
    property string projectPath:rootMode ? "/usr/share/": homePath+"/tIDE/Projects"
    property string patchPath:rootMode ? "/usr/share/": homePath+"/tIDE/Patches"
    property string buildPath: homePath+"/rpmbuild"
    property string projectName
    property string filePath
    property string singleFile
    property string projectQmlPath:(projectPath +"/"+ projectName+"/qml/"+ projectName+".qml");
    //property bool split: false
    property bool rootMode: root

    Notification{
        id:notification
    }
    function showError(message) {
        notification.category="x-nemo.example"
        notification.previewBody = message;
        notification.close();
        notification.publish();
    }

    //Reverse theme color
    function reverseColor(color, light) {
        if(light === undefined)
            light = 3.0;

        return Qt.lighter(Qt.rgba(1.0 - color.r, 1.0 - color.g, 1.0 - color.b, 1.0), light);
    }

    //Settings
    property int fontSize//:Theme.fontSizeMedium
    onFontSizeChanged: setSetting('fontsize', fontSize)
    property string fontType//: Theme.fontFamily
    onFontTypeChanged: setSetting('fonttype', fontType)
    property bool lineNums//: true
    onLineNumsChanged: setSetting('linenums',lineNums)
    property bool autoSave//: false
    onAutoSaveChanged: setSetting('autosave',autoSave)
    property int indentSize//:4
    property string indentString: "    "
    onIndentSizeChanged: {
        setSetting('indentsize',indentSize)
        var indentString = ""
        for (var i = 0; i < indentSize; i++)
            indentString += " "
        appWindow.indentString = indentString
    }
    property bool darkTheme//: false
    onDarkThemeChanged: setSetting("darktheme",darkTheme)
    property string textColor//:Theme.primaryColor
    onTextColorChanged: setSetting('textcolor',textColor)
    property string qmlHighlightColor//:Theme.highlightColor
    onQmlHighlightColorChanged: setSetting('qmlcolor',qmlHighlightColor)
    property string keywordsHighlightColor//:Theme.highlightDimmerColor
    onKeywordsHighlightColorChanged: setSetting('keycolor',keywordsHighlightColor)
    property string propertiesHighlightColor//:Theme.primaryColor
    onPropertiesHighlightColorChanged: setSetting('propertiescolor',propertiesHighlightColor)
    property string javascriptHighlightColor//:Theme.secondaryHighlightColor
    onJavascriptHighlightColorChanged: setSetting('jscolor',javascriptHighlightColor)
    property string stringHighlightColor//:Theme.secondaryColor
    onStringHighlightColorChanged: setSetting('strcolor',stringHighlightColor)
    property string commentHighlightColor//: Theme.highlightBackgroundColor
    onCommentHighlightColorChanged: setSetting('commentcolor',commentHighlightColor)
    property string bgColor//:"transparent"
    onBgColorChanged: setSetting('bgcolor',bgColor)
    property bool trace //:false
    onTraceChanged: setSetting('trace', trace)
    property int hint//:0
    onHintChanged: setSetting('hint',hint)
    property bool plugins //:
    onPluginsChanged: setSetting('plugins',plugins)
    property int wrapMode//: 3
    onWrapModeChanged: setSetting('wrapmode', wrapMode)
    property int tabSize//:4
    onTabSizeChanged: {
        //temporary
        py.call('settings.setTab', ['tabsize',tabSize], function(result) {});
    }

    function setSetting(key, value){
        py.call('settings.set', [key, value], function(result) {});
    }

    Python {
        id: py
        Component.onCompleted: {
            addImportPath(Qt.resolvedUrl('./python'));
            importModule('settings', function () {
                //getSettings
                py.call('settings.setDataPath', [StandardPaths.data], function(){
                    py.call('settings.get', ['darktheme'], function(result) {
                        if (result=="True") darkTheme=true
                        else darkTheme=false
                    });
                    py.call('settings.get', ['fontsize'], function(result) {fontSize=result});
                    py.call('settings.get', ['fonttype'], function(result) {fontType=result});
                    py.call('settings.get', ['linenums'], function(result) {
                        if (result=="True") lineNums=true
                        else lineNums=false
                    });
                    py.call('settings.get', ['autosave'], function(result) {
                        if (result=="True") autoSave=true
                        else autoSave=false
                    });
                    py.call('settings.get', ['indentsize'], function(result) {indentSize=result});
                    py.call('settings.get', ['textcolor'], function(result) {textColor=result});
                    py.call('settings.get', ['qmlcolor'], function(result) {qmlHighlightColor=result});
                    py.call('settings.get', ['keycolor'], function(result) {keywordsHighlightColor=result});
                    py.call('settings.get', ['propertiescolor'], function(result) {propertiesHighlightColor=result});
                    py.call('settings.get', ['jscolor'], function(result) {javascriptHighlightColor=result});
                    py.call('settings.get', ['strcolor'], function(result) {stringHighlightColor=result});
                    py.call('settings.get', ['commentcolor'], function(result) {commentHighlightColor=result});
                    py.call('settings.get', ['bgcolor'], function(result) {bgColor=result});
                    py.call('settings.get', ['trace'], function(result) {
                        if (result=="True") trace=true
                        else trace=false
                    });
                    py.call('settings.get', ['hint'], function(result) {hint=result});
                    py.call('settings.get', ['plugins'], function(result) {
                        if (result=="True") plugins=true
                        else plugins=false
                    });
                    py.call('settings.get', ['wrapmode'], function(result) {wrapMode=result})
                    py.call('settings.getTab', ['tabsize'], function(result) {tabSize=result});
                });

            });
        }
        onError: {
            showError(traceback)
            // when an exception is raised, this error handler will be called
            console.log('python error: ' + traceback);
        }
    }
}


