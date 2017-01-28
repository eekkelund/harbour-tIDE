/*****************************************************************************
 *
 * Created: 2016 by Eetu Kahelin / eekkelund
 *
 * Copyright 2016 Eetu Kahelin. All rights reserved.
 *
 * This file may be distributed under the terms of GNU Public License version
 * 3 (GPL v3) as defined by the Free Software Foundation (FSF). A copy of the
 * license should have been included with this file, or the project in which
 * this file belongs to. You may also find the details of GPL v3 at:
 * http://www.gnu.org/licenses/gpl-3.0.txt
 *
 * If you have any questions regarding the use of this file, feel free to
 * contact the author of this file, or the owner of the project in which
 * this file belongs to.
*****************************************************************************/

#ifndef REALHIGHLIGHTER_H
#define REALHIGHLIGHTER_H

#include <QObject>
#include <QTextCharFormat>
#include <QSyntaxHighlighter>
#include <QHash>

class QTextDocument;

class RealHighlighter : public QSyntaxHighlighter
{
    Q_OBJECT

public:
    RealHighlighter(QTextDocument *parent = 0);

    void setStyle(QString primaryColor, QString secondaryColor, QString highlightColor, QString secondaryHighlightColor, QString highlightBackgroundColor, QString highlightDimmerColor, qreal m_baseFontPointSize);
    void setDictionary(QString dictionary);

protected:
    void highlightBlock(const QString &text) Q_DECL_OVERRIDE;

private:
    void ruleUpdate();

    class HighlightingRule
    {
    public:
        QRegExp pattern;
        QTextCharFormat format;
    };

    QVector<HighlightingRule> highlightingRules;

    QRegExp commentStartExpression;
    QRegExp commentEndExpression;

    QString m_primaryColor;
    QString m_secondaryColor;
    QString m_highlightColor;
    QString m_secondaryHighlightColor;
    QString m_highlightBackgroundColor;
    QString m_highlightDimmerColor;
    QString m_dictionary;
    qreal m_baseFontPointSize;

    QTextCharFormat keywordFormat;
    QTextCharFormat qmlFormat;
    QTextCharFormat jsFormat;
    QTextCharFormat propertiesFormat;
    QTextCharFormat pythonFormat;
    QTextCharFormat singleLineCommentFormat;
     QTextCharFormat multiLineCommentFormat;
     QTextCharFormat quotationFormat;
     QTextCharFormat functionFormat;
     QTextCharFormat numberFormat;
    void loadDict(QString path, QStringList &patterns);
};

#endif // REALHIGHLIGHTER_H
