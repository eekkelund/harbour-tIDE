import QtQuick 2.2
import Sailfish.Silica 1.0

Page {
    id:page
    SilicaFlickable {
        anchors.fill: parent
         contentHeight: column.height + Theme.paddingLarge
        VerticalScrollDecorator {}
        Column {
            id: column
            spacing: Theme.paddingMedium
            width: parent.width

            PageHeader {
                title: qsTr("Settings")
            }
            SectionHeader {
                text: qsTr("Appearance & Theme")
            }


            TextSwitch {
                text: qsTr("Line numbers")
                checked: lineNums
                onCheckedChanged: {
                    lineNums = checked

                }
            }
            TextSwitch {
                checked: darkTheme
                text: qsTr("Dark Theme")
                onCheckedChanged: {
                    darkTheme = checked
                    if(darkTheme){
                        textColor="#cfbfad"
                        qmlHighlightColor="#ff8bff"
                        keywordsHighlightColor="#808bed"
                        propertiesHighlightColor="#ff5555"
                        javascriptHighlightColor="#8888ff"
                        stringHighlightColor="#ffcd8b"
                        commentHighlightColor="#cd8b00"
                    }else{
                        textColor=Theme.primaryColor
                        qmlHighlightColor=Theme.highlightColor
                        keywordsHighlightColor=Theme.highlightDimmerColor
                        propertiesHighlightColor=Theme.primaryColor
                        javascriptHighlightColor=Theme.secondaryHighlightColor
                        stringHighlightColor=Theme.secondaryColor
                        commentHighlightColor= Theme.highlightBackgroundColor
                    }
                }
            }


            ComboBox {
                label: qsTr("Color of:")
                value: "Asd"

                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("ExtraSmall")
                        onClicked:{

                        }
                    }
                    MenuItem {
                        text: qsTr("Small")
                        onClicked:{

                        }
                    }
                }
            }




            SectionHeader {
                text: qsTr("Automatic")
            }
            TextSwitch {
                text: qsTr("Auto saving")
                checked: autoSave
                onCheckedChanged: {
                    autoSave = checked
                }
            }
            Slider {
                label: qsTr("Indent size")
                width: parent.width
                value: indentSize
                minimumValue: 0
                valueText: (value==0) ? qsTr("Off") : value
                stepSize:1
                maximumValue: 8
                onReleased: {
                    indentSize = sliderValue
                }
            }

            SectionHeader {
                text: qsTr("Font")
            }
            ComboBox {
                label: qsTr("Font size:")
                value: fontSize

                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("ExtraSmall")
                        onClicked:{
                            fontSize = Theme.fontSizeExtraSmall;
                        }
                    }
                    MenuItem {
                        text: qsTr("Small")
                        onClicked:{
                            fontSize = Theme.fontSizeSmall;
                        }
                    }
                    MenuItem {
                        text: qsTr("Medium")
                        onClicked:{
                            fontSize = Theme.fontSizeMedium;
                        }
                    }
                    MenuItem {
                        text:qsTr("Large")
                        onClicked:{
                            fontSize = Theme.fontSizeLarge;
                        }
                    }
                }
            }

            ComboBox {
                label: qsTr("Font:")
                value: fontType

                menu: ContextMenu {
                    MenuItem {
                        text: qsTr("Sail Sans Pro Light")
                        onClicked:{
                            fontType = Theme.fontFamily;
                        }
                    }
                    MenuItem {
                        text: qsTr("Open Sans")
                        onClicked:{
                            fontType = "Open Sans";
                        }
                    }
                    MenuItem {
                        text:qsTr("Helvetica")
                        onClicked:{
                            fontType = "Helvetica";
                        }
                    }
                    MenuItem {
                        text: qsTr("Droid Sans Mono")
                        onClicked:{
                            fontType = "Droid Sans Mono";
                        }
                    }
                    MenuItem {
                        text: qsTr("Comic Sans")
                        onClicked:{
                            fontType = "Comic Sans";
                        }
                    }
                    MenuItem {
                        text: qsTr("Ubuntu")
                        onClicked:{
                            fontType = "Ubuntu";
                        }
                    }
                    MenuItem {
                        text: qsTr("DejaVu Sans Mono")
                        onClicked:{
                            fontType = "DejaVu Sans Mono";
                        }
                    }
                }
            }

        }


    }

}

