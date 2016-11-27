import QtQuick 2.0
import Sailfish.Silica 1.0
import "pages"


ApplicationWindow
{
    initialPage: Component { MainPage {
            id:home
        } }
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    allowedOrientations: Orientation.All
    _defaultPageOrientations: Orientation.All

    property string projectPath: "/home"+"/nemo/Projects"
    property string buildPath: "/home"+"/nemo/rpmbuild"
    property string projectName
    property string filePath
    property string singleFile
    property string homePath: "/home/nemo"
    property string projectQmlPath:(projectPath +"/"+ projectName+"/qml/"+ projectName+".qml");
}


