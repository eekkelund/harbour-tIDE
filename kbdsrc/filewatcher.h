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
#ifndef FILEWATCHER_H
#define FILEWATCHER_H

#include <QObject>
#include <QFileSystemWatcher>
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
