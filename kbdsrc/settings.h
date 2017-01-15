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
#ifndef SETTINGS_H
#define SETTINGS_H

#include <QQuickItem>
#include <QSettings>
#include <QString>
#include <QStandardPaths>


class Settings : public QQuickItem
{

    Q_OBJECT

public:
    Q_INVOKABLE QVariant load(QString name);
    Settings(QQuickItem *parent=0);
};


#endif // SETTINGS_H
