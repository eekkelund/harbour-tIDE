#ifndef FILEWATCHER_H
#define FILEWATCHER_H

#include <QObject>
#include <QFileSystemWatcher>
#include <QDebug>
#include <QSettings>
#include <QString>
#include <QFileInfo>


class FileWatcher : public QObject
{
    Q_OBJECT
public:
    explicit FileWatcher();

signals:
    void changed(QString type);

public slots:

private slots:

    void directoryChanged(const QString & path);
    void fileChanged(const QString & path);
private:
    QFileSystemWatcher * watcher;
};

#endif // FILEWATCHER_H
