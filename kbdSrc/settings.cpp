#include "settings.h"
#include <QSettings>
#include <QString>
#include <QProcess>
#include <QStandardPaths>

Settings::Settings(QQuickItem *parent)
    : QQuickItem(parent)
{

}

QVariant Settings::load(QString name)
{
    QSettings settings("/var/lib/harbour-sailorcreator-keyboard/config/config.conf", QSettings::IniFormat);
    return settings.value(name);

}
