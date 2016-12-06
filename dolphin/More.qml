import QtQuick 2.2
import Sailfish.Silica 1.0
import com.jolla.keyboard 1.0

BackgroundItem {
    id: footer
    width: 52
    height: parent.height
    visible: ( result.length >= 8 && !fetchMany && !keyboard.inSymView && !keyboard.inSymView2 )
    anchors.top: parent.top
    x: parent.width - 52
	
    z: 768

    	Image {
        source: "image://theme/icon-lock-more?" + Theme.highlightColor
        anchors.centerIn: parent
        z: 16
    }

    onPressed: {
        buttonPressEffect.play()
        SampleCache.play("/usr/share/sounds/jolla-ambient/stereo/keyboard_letter.wav")
    }

    onClicked: {

        if ( preedit !== "" && result.length > 0 && result.length <= 16 ) {
            applyMoreWord()
            console.warn(result)
            //database.enter()
        }

        fetchMany = true

    }
}
