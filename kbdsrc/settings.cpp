#include "settings.h"

Settings::Settings(QQuickItem *parent)
    : QQuickItem(parent)
{

}

QVariant Settings::load(QString name)
{
    QSettings settings("/var/lib/harbour-tide-keyboard/config/config.conf", QSettings::IniFormat);
    return settings.value(name);

}
