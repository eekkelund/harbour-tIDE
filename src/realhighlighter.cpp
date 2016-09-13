#include "realhighlighter.h"

#include <QtGui>


RealHighlighter::RealHighlighter(QTextDocument *parent): QSyntaxHighlighter(parent)
{


}
void RealHighlighter::loadDict(QString path, QStringList &patterns){
    QFile dict(path);
    if (dict.open(QIODevice::ReadOnly))
    {

        qDebug()<<dict.isOpen();
        QTextStream textStream(&dict);
        while (true)
        {

            QString line = textStream.readLine();
            if (line.isNull())
                break;
            else
                patterns.append("\\b"+line+"\\b");

        }
        dict.close();
    }
}

void RealHighlighter::ruleUpdate()
{
    HighlightingRule rule;
    highlightingRules.clear();


    qmlFormat.setForeground(QColor(m_highlightColor));
    qmlFormat.setFontWeight(QFont::Bold);
    QStringList qmlPatterns;
    loadDict(":/dictionaries/qml.txt",qmlPatterns);

    foreach (const QString &pattern, qmlPatterns) {
        rule.pattern = QRegExp(pattern);
        rule.format = qmlFormat;
        highlightingRules.append(rule);
    }

    keywordFormat.setForeground(QColor(m_secondaryHighlightColor));
    keywordFormat.setFontWeight(QFont::Bold);
    QStringList keywordPatterns;
    loadDict(":/dictionaries/keywords.txt",keywordPatterns);

    foreach (const QString &pattern, keywordPatterns) {
        rule.pattern = QRegExp(pattern);
        rule.format = keywordFormat;
        highlightingRules.append(rule);
    }
    jsFormat.setForeground(QColor(m_secondaryColor));
    jsFormat.setFontWeight(QFont::Bold);
    QStringList jsPatterns;
    loadDict(":/dictionaries/javascript.txt",jsPatterns);

    foreach (const QString &pattern, jsPatterns) {
        rule.pattern = QRegExp(pattern);
        rule.format = jsFormat;
        highlightingRules.append(rule);
    }
    propertiesFormat.setForeground(QColor(m_primaryColor));
    propertiesFormat.setFontWeight(QFont::Bold);
    QStringList propertiesPatterns;
    loadDict(":/dictionaries/properties.txt",propertiesPatterns);

    foreach (const QString &pattern, propertiesPatterns) {
        rule.pattern = QRegExp(pattern);
        rule.format = propertiesFormat;
        highlightingRules.append(rule);
    }


}

void RealHighlighter::highlightBlock(const QString &text)
{
    foreach (const HighlightingRule &rule, highlightingRules) {
        QRegExp expression(rule.pattern);
        int index = expression.indexIn(text);
        while (index >= 0) {
            int length = expression.matchedLength();
            setFormat(index, length, rule.format);
            index = expression.indexIn(text, index + length);
        }
    }
    enum {
        StartState = 0,
        NumberState = 1,
        IdentifierState = 2,
        StringState = 3,
        CommentState = 4
    };

    QList<int> bracketPositions;

    int blockState = previousBlockState();
    int bracketLevel = blockState >> 4;
    int state = blockState & 15;
    if (blockState < 0) {
        bracketLevel = 0;
        state = StartState;
    }

    int start = 0;
    int i = 0;
    while (i <= text.length()) {
        QChar ch = (i < text.length()) ? text.at(i) : QChar();
        QChar next = (i < text.length() - 1) ? text.at(i + 1) : QChar();

        switch (state) {

        case StartState:
            start = i;
            if (ch.isSpace()) {
                ++i;
            } else if (ch.isDigit()) {
                ++i;
                state = NumberState;
            } else if (ch.isLetter() || ch == '_') {
                ++i;
                state = IdentifierState;
            } else if (ch == '\'' || ch == '\"') {
                ++i;
                state = StringState;
            } else if (ch == '/' && next == '*') {
                ++i;
                ++i;
                state = CommentState;
            } else if (ch == '/' && next == '/') {
                i = text.length();
                setFormat(start, text.length(), Qt::darkBlue);
            } else {
                if (!QString("(){}[]").contains(ch))
                    //setFormat(start, 1, Qt::green);
                if (ch =='{' || ch == '}') {
                    bracketPositions += i;
                    if (ch == '{')
                        bracketLevel++;
                    else
                        bracketLevel--;
                }
                ++i;
                state = StartState;
            }
            break;

        case NumberState:
            if (ch.isSpace() || !ch.isDigit()) {
                setFormat(start, i - start, Qt::red);
                state = StartState;
            } else {
                ++i;
            }
            break;

        /*case IdentifierState:
            if (ch.isSpace() || !(ch.isDigit() || ch.isLetter() || ch == '_')) {
                QString token = text.mid(start, i - start).trimmed();
                if (keywordPatterns.contains(token))
                    setFormat(start, i - start, Qt::darkBlue);
                //else if (m_qmlIdsCache.contains(token) || m_qmlIds.contains(token))
                    setFormat(start, i - start, Qt::darkBlue);
                //else if (m_propertiesCache.contains(token))
                    setFormat(start, i - start, Qt::darkBlue);
                //else if (m_jsIdsCache.contains(token) || m_jsIds.contains(token))
                    setFormat(start, i - start, Qt::darkBlue);
                state = StartState;
            } else {
                ++i;
            }
            break;*/

        case StringState:
            if (ch == text.at(start)) {
                QChar prev = (i > 0) ? text.at(i - 1) : QChar();
                if (prev != '\\') {
                    ++i;
                    setFormat(start, i - start, Qt::blue);
                    state = StartState;
                } else {
                    ++i;
                }
            } else {
                ++i;
            }
            break;

        case CommentState:
            if (ch == '*' && next == '/') {
                ++i;
                ++i;
                setFormat(start, i - start, QColor(m_highlightDimmerColor));
                state = StartState;
            } else {
                ++i;
            }
            break;

        default:
            state = StartState;
            break;
        }
    }

    if (state == CommentState)
        setFormat(start, text.length(), QColor(m_highlightBackgroundColor));
    else
        state = StartState;

    /*if (!m_markString.isEmpty()) {
        int pos = 0;
        int len = m_markString.length();
        QTextCharFormat markerFormat;
        markerFormat.setBackground(Qt::darkBlue);
        markerFormat.setForeground(Qt::darkBlue);
        for (;;) {
            pos = text.indexOf(m_markString, pos, m_markCaseSensitivity);
            if (pos < 0)
                break;
            setFormat(pos, len, markerFormat);
            ++pos;
        }
    }*/

    blockState = (state & 15) | (bracketLevel << 4);
    setCurrentBlockState(blockState);
}
void RealHighlighter::setStyle(QString primaryColor, QString secondaryColor, QString highlightColor, QString secondaryHighlightColor, QString highlightBackgroundColor, QString highlightDimmerColor, qreal baseFontPointSize)
{
    m_primaryColor = QString(primaryColor);
    m_secondaryColor = QString(secondaryColor);
    m_highlightColor = QString(highlightColor);
    m_secondaryHighlightColor = QString(secondaryHighlightColor);
    m_highlightBackgroundColor = QString(highlightBackgroundColor);
    m_highlightDimmerColor = QString(highlightDimmerColor);
    m_baseFontPointSize = baseFontPointSize;
    this->ruleUpdate();
    this->rehighlight();
}

