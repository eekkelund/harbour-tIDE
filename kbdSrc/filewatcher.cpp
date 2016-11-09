#include "filewatcher.h"


FileWatcher::FileWatcher()
{
    watcher=0;
    watcher = new QFileSystemWatcher(this);
    connect(watcher, SIGNAL(fileChanged(const QString &)), this, SLOT(fileChanged(const QString &)));
    connect(watcher, SIGNAL(directoryChanged(const QString &)), this, SLOT(directoryChanged(const QString &)));
    watcher->addPath("/var/lib/harbour-sailorcreator-keyboard/config/");
    watcher->addPath("/var/lib/harbour-sailorcreator-keyboard/config/config.conf");
}

void FileWatcher::directoryChanged(const QString & path)
{
  qDebug() << path;
  //QSettings settings(QString(path), QSettings::IniFormat);
  //QString someValue = settings.value("fileType/type", "default value if unset").toString(); // settings.value() returns QVariant
  //qDebug() << someValue;
}

void FileWatcher::fileChanged(const QString & path)
{
    qDebug() << path;
    QFileInfo checkFile(path);
    QSettings settings(QString(path), QSettings::IniFormat);
    QString type = settings.value("fileType/type", "qml").toString(); // settings.value() returns QVariant
    qDebug() << type;
    emit changed(type);
    while(!checkFile.exists()){}
    //std::this_thread::sleep_for(std::chrono::milliseconds(10));
    watcher->addPath(path);
}
