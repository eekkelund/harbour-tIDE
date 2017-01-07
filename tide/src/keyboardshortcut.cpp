#include "keyboardshortcut.h"

#include <QKeyEvent>
#include <QCoreApplication>
#include <QDebug>
//#include <QLineEdit>
//#include <QGraphicsScene>

KeyboardShortcut::KeyboardShortcut(QObject *parent)
    : QObject(parent)
    , m_keySequence()
    , m_keypressAlreadySend(false)
{
    qApp->installEventFilter(this);
}

void KeyboardShortcut::setKey(QVariant key)
{
    QKeySequence newKey = key.value<QKeySequence>();
    if(m_keySequence != newKey) {
        m_keySequence = key.value<QKeySequence>();
        emit keyChanged();
    }
}

bool KeyboardShortcut::eventFilter(QObject *obj, QEvent *e)
{
    if(e->type() == QEvent::KeyPress && !m_keySequence.isEmpty()) {
//If you want some Key event was not filtered, add conditions to here
        //if ((dynamic_cast<QGraphicsScene*>(obj)) || (obj->objectName() == "blockShortcut") || (dynamic_cast<QLineEdit*>(obj)) ){
        //    return QObject::eventFilter(obj, e);
        //}
        QKeyEvent *keyEvent = static_cast<QKeyEvent*>(e);

        // Just mod keys is not enough for a shortcut, block them just by returning.
        if (keyEvent->key() >= Qt::Key_Shift && keyEvent->key() <= Qt::Key_Alt) {
            return QObject::eventFilter(obj, e);
        }

        int keyInt = keyEvent->modifiers() + keyEvent->key();

        if(!m_keypressAlreadySend && QKeySequence(keyInt) == m_keySequence) {
            m_keypressAlreadySend = true;
            emit activated();
        }
    }
    else if(e->type() == QEvent::KeyRelease) {
        m_keypressAlreadySend = false;
    }
    return QObject::eventFilter(obj, e);
}
