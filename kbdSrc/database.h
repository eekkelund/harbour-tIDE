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
#ifndef DATABASE_H
#define DATABASE_H
#include <QSqlDatabase>
#include <QQuickItem>
#include <QStringList>
#include <QDir>
#include <QtSql>
#include <QFile>
#include <QObject>
#include <QSqlError>
#include <QSqlQuery>
#include <QQuickItem>
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
