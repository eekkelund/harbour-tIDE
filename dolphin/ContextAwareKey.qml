import QtQuick 2.2
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0

CharacterKey {
    caption: MInputMethodQuick.contentType === Maliit.UrlContentType
             ? "/"
             : MInputMethodQuick.contentType === Maliit.EmailContentType
               ? "@"
               : "."
    captionShifted: caption
    symView: "."
    symView2: "."
    accents: ";:"
    accentsShifted: ";:"
    implicitWidth: punctuationKeyWidth
    fixedWidth: !splitActive
    separator: SeparatorState.HiddenSeparator
}
