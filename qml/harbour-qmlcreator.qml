import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"

ApplicationWindow
{
    initialPage: Component { CreatorHome { } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    property string projectPath: "/home/nemo/Projects"
    property string projectName
    property string filePath
    property string projectQmlPath:(projectPath +"/"+ projectName+"/qml/"+ projectName+".qml");
}


