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
}
//checks if config file is changed=different filetype opened
void FileWatcher::fileChanged(const QString & path)
{
    QFileInfo checkFile(path);
    QSettings settings(QString(path), QSettings::IniFormat);
    QString type = settings.value("fileType/type", "qml").toString();
    emit changed(type);
    while(!checkFile.exists()){}
    watcher->addPath(path);
}
