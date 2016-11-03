#ifndef SETTINGS_H
#define SETTINGS_H

#include <QQuickItem>
#include <QSettings>
#include <QString>
//#include <QProcess>
#include <QStandardPaths>


class Settings : public QQuickItem
{

    Q_OBJECT

public:
    Q_INVOKABLE QVariant load(QString name);
    Settings(QQuickItem *parent=0);
};


#endif // SETTINGS_H
