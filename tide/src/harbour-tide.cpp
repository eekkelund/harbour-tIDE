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
#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QQuickView>
#include <QGuiApplication>
#include <QQmlEngine>
#include <QString>
#include "documenthandler.h"
#include "iconprovider.h"


int main(int argc, char *argv[])
{
    qmlRegisterType<DocumentHandler>("harbour.tide.documenthandler", 1, 0, "DocumentHandler");
    QGuiApplication *app = SailfishApp::application(argc, argv);
    QQuickView *view = SailfishApp::createView();
    QQmlEngine *engine = view->engine();
    engine->addImageProvider(QLatin1String("ownIcons"), new IconProvider);
    view->setSource(SailfishApp::pathTo("qml/harbour-tide.qml"));
    view->showFullScreen();

    return app->exec();

}

