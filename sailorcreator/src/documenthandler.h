#ifndef DOCUMENTHANDLER_H
#define DOCUMENTHANDLER_H

#include <QQuickTextDocument>
#include "realhighlighter.h"
#include <QtGui/QTextCharFormat>
#include <QtCore/QTextCodec>

#include <qqmlfile.h>

QT_BEGIN_NAMESPACE
class QTextDocument;
QT_END_NAMESPACE


class DocumentHandler : public QObject
{
    Q_OBJECT
    Q_ENUMS(HAlignment)

    Q_PROPERTY(QQuickItem *target READ target WRITE setTarget NOTIFY targetChanged)
    Q_PROPERTY(int cursorPosition READ cursorPosition WRITE setCursorPosition NOTIFY cursorPositionChanged)
    Q_PROPERTY(int selectionStart READ selectionStart WRITE setSelectionStart NOTIFY selectionStartChanged)
    Q_PROPERTY(int selectionEnd READ selectionEnd WRITE setSelectionEnd NOTIFY selectionEndChanged)

    Q_PROPERTY(QString text READ text WRITE setText NOTIFY textChanged)



public:
    DocumentHandler();

    QQuickItem * target() const
    {
        return m_target;
    }

    int cursorPosition() const
    {
        return m_cursorPosition;
    }

    int selectionStart() const
    {
        return m_selectionStart;
    }

    int selectionEnd() const
    {
        return m_selectionEnd;
    }

    void setTarget(QQuickItem * target);
    void setCursorPosition(int position);
    void setSelectionStart(int position);
    void setSelectionEnd(int position);

    QString text() const;



Q_SIGNALS:

    void targetChanged();

    void cursorPositionChanged();

    void selectionStartChanged();

    void selectionEndChanged();

    void textChanged();

public Q_SLOTS:

    void setText(QString &arg);
    void setStyle(QString primaryColor, QString secondaryColor, QString highlightColor, QString secondaryHighlightColor, QString highlightBackgroundColor, QString highlightDimmerColor, qreal m_baseFontPointSize);

private:

    QTextCursor textCursor() const;
    void mergeFormatOnWordOrSelection(const QTextCharFormat &format);

    QQuickItem * m_target;
    QTextDocument *m_doc;

    int m_cursorPosition;

    int m_selectionStart;

    int m_selectionEnd;

    QString m_text;

    RealHighlighter *m_realhighlighter;


};


#endif // DOCUMENTHANDLER_H
