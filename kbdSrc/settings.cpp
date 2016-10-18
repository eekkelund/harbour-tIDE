#include "settings.h"
#include <QSettings>
#include <QString>
#include <QProcess>
#include <QStandardPaths>

Settings::Settings(QQuickItem *parent)
    : QQuickItem(parent)
{

}


void Settings::save(QString name, QString data)
{

    QSettings settings("/var/lib/harbour-dolphin-keyboard/config/config.conf", QSettings::IniFormat);
    settings.setValue(name, data);
    settings.sync();

}

void Settings::restart()
{
    QProcess shell;
    shell.startDetached("systemctl", QStringList() << "--user" << "restart" << "maliit-server.service");
    //qDebug() << shell.errorString();


}

void Settings::backup()
{

    QProcess shell;
    shell.startDetached("mkdir", QStringList() << "/home/nemo/Saber");
    shell.startDetached("/bin/cp", QStringList() << "-rf" << "/usr/share/harbour-dolphin-keyboard/database/dp-hk.sqlite" << "/home/nemo/Dolphin/dp-hk.sqlite");
    qDebug() << shell.errorString();


}

void Settings::restore()
{
    QProcess shell;
    shell.startDetached("/bin/cp", QStringList() << "-rf" << "/home/nemo/Dolphin/dp-hk.sqlite" << "/usr/share/harbour-dolphin-keyboard/dp-hk.sqlite");
    qDebug() << shell.errorString();
}

QVariant Settings::load(QString name)
{
    QSettings settings("/var/lib/harbour-dolphin-keyboard/config/config.conf", QSettings::IniFormat);
    return settings.value(name);

}
