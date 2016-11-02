#ifndef DATABASE_H
#define DATABASE_H
#include <QSqlDatabase>
#include <QQuickItem>
#include <QStringList>
#include <QVariantList>
#include <QMap>
#include <QDir>
#include <QtSql>
#include <QSqlDatabase>
#include <QFile>
#include <QObject>
#include <QSqlError>
#include <QSqlQuery>
#include <QQuickItem>
#include <QDebug>
#include <QStringList>
#include <QFileInfo>
#include "filewatcher.h"

class Database : public QQuickItem
{

    Q_OBJECT
    Q_PROPERTY(QString name READ name WRITE setName NOTIFY nameChanged)

public slots:
    void update(QString sql);
    void initial(QString name);
    void close(QString name);
    void output(QString sql);
    void adjust(QString name, QString word);
    void debug(QString sql);
    void index(QString name);
    void changed(QString type);

public:
    ~Database();
    //QString name() const;
    Q_INVOKABLE QStringList load(QString sql);
    Q_INVOKABLE QStringList predict(QString sql, QString size);
    //Q_INVOKABLE bool adjust(QString name, QString word);
    Database(QQuickItem *parent = 0);
    QSqlDatabase database;

    Q_INVOKABLE QStringList develop(QString keys, QString size);

    QString name() const;

Q_SIGNALS:
    void nameChanged();

public Q_SLOTS:
    void setName(QString name);

private slots:

  //void directoryChanged(const QString & path);
  //void fileChanged(const QString & path);

private:

 // QFileSystemWatcher * watcher;

    QString m_name;

};


#endif // DATABASE_H
