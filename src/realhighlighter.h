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

    void setStyle(QString primaryColor, QString secondaryColor, QString highlightColor, QString secondaryHighlightColor, qreal m_baseFontPointSize);

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
    qreal m_baseFontPointSize;

    QTextCharFormat keywordFormat;
    QTextCharFormat qmlFormat;
    QTextCharFormat jsFormat;
    QTextCharFormat propertiesFormat;
    QTextCharFormat quotationFormat;
    QTextCharFormat functionFormat;
    void loadDict(QString path, QStringList &patterns);
};

#endif // REALHIGHLIGHTER_H
