#ifndef FILEWATCHER_H
#define FILEWATCHER_H

#include <QObject>

class FileWatcher : public QObject
{
    Q_OBJECT
public:
    explicit FileWatcher(QObject *parent = 0);

signals:

public slots:
};

#endif // FILEWATCHER_H