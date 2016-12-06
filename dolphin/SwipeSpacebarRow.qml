/*
 * Copyright (C) 2013 Jolla ltd and/or its subsidiary(-ies). All rights reserved.
 *
 * Contact: Pekka Vuorela <pekka.vuorela@jollamobile.com>
 *
 * Redistribution and use in source and binary forms, with or without modification,
 * are permitted provided that the following conditions are met:
 *
 * Redistributions of source code must retain the above copyright notice, this list
 * of conditions and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list
 * of conditions and the following disclaimer in the documentation and/or other materials
 * provided with the distribution.
 * Neither the name of Nokia Corporation nor the names of its contributors may be
 * used to endorse or promote products derived from this software without specific
 * prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
 * EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL
 * THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
 * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
 * HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */
import QtQuick 2.2
import com.meego.maliitquick 1.0
import com.jolla.keyboard 1.0


KeyboardRow {
    splitIndex: 5
    property int keyWidth: ( parent.width - shiftKeyWidth ) / 12

    PunctuationKey {
        width:  keyWidth * 2.2
    }

    /*LanguageKey {
        width:  keyWidth * 2.2
    }*/

    CharacterKey {
        caption: MInputMethodQuick.contentType === Maliit.EmailContentType? ".": ( MInputMethodQuick.contentType === Maliit.UrlContentType? ".": ( xt9? ".": "。" ) )
        captionShifted: MInputMethodQuick.contentType === Maliit.EmailContentType? ".": ( MInputMethodQuick.contentType === Maliit.UrlContentType? ".": ( xt9? ".": "。" ) )
        symView: ","
        symView2: ","
        fixedWidth: true
        width:  keyWidth * 1.5
    }

    SpacebarKey {
        width:  keyWidth * 4.6
        fixedWidth: true
    }

    CharacterKey {
        caption: MInputMethodQuick.contentType === Maliit.EmailContentType? ".": ( MInputMethodQuick.contentType === Maliit.UrlContentType? ".": ( xt9? ".": "。" ) )
        captionShifted: MInputMethodQuick.contentType === Maliit.EmailContentType? ".": ( MInputMethodQuick.contentType === Maliit.UrlContentType? ".": ( xt9? ".": "。" ) )
        symView: "."
        symView2: "."
        fixedWidth: true
        width:  keyWidth * 1.5
    }

    EnterKey { width: shiftKeyWidth }
}
