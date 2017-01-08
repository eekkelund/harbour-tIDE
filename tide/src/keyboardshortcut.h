#ifndef KEYBOARDSHORTCUT_H
#define KEYBOARDSHORTCUT_H

//#include <QDeclarativeItem>
#include <QObject>
#include <QKeySequence>
#include <QVariant>

class KeyboardShortcut: public QObject
{
    Q_OBJECT
    Q_PROPERTY(QVariant key READ key WRITE setKey NOTIFY keyChanged)
public:
    explicit KeyboardShortcut(QObject *parent = 0);

    void setKey(QVariant key);
    QVariant key() { return m_keySequence; }

    bool eventFilter(QObject *obj, QEvent *e);

signals:
    void keyChanged();
    void activated();
    void pressedAndHold();

public slots:

private:
    QKeySequence m_keySequence;
    bool m_keypressAlreadySend;
};

#endif // KEYBOARDSHORTCUT_H
