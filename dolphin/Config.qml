import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.sailorcreator.keyboard 1.0


Settings {
    id: config

    property int spacebar: config.load("spacebar")
    property int keys: config.load("keys")
    property int word: config.load("word")

    property int toolbar: config.load("toolbar")
    property int fusion: config.load("fusion")
    property int enMode: config.load("enMode")
    property int swipe: config.load("swipe")

    property real scale: config.load("ui-scale")
    property int size: config.load("ui-size")
    property string background: config.load("ui-background")
    property real transparency: config.load("ui-opacity")

    property int emoji: config.load("emoji-keyboard")
    property var frequent: config.load("emoji-frequent") ? config.load("emoji-frequent").split(",") :[]
}
