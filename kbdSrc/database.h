#ifndef DATABASE_H
#define DATABASE_H
#include <QSqlDatabase>
#include <QQuickItem>
#include <QStringList>
#include <QVariantList>
#include <QMap>
#include <QDir>
#include <QtSql>
#include <QFile>
#include <QObject>
#include <QSqlError>
#include <QSqlQuery>
#include <QQuickItem>
//#include <QDebug>
#include <QStringList>
#include <QFileInfo>
#include "filewatcher.h"

class Database : public QQuickItem
{

    Q_OBJECT

public slots:
    void update(QString sql);
    void initial(QString name);
    void close(QString name);
    void adjust(QString name, QString word);
    void index(QString name);
    void changed(QString type);

public:
    ~Database();
    Q_INVOKABLE QStringList load(QString sql);
    Q_INVOKABLE QStringList predict(QString sql, QString size);
    Database(QQuickItem *parent = 0);
    QSqlDatabase database;

    Q_INVOKABLE QStringList develop(QString keys, QString size);

};


#endif // DATABASE_H
