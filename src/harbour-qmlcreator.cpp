#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <sailfishapp.h>
#include <QQuickView>
#include <QGuiApplication>
#include <QDebug>
//#include <QTextEdit>
#include <QString>
#include "documenthandler.h"


int main(int argc, char *argv[])
{

    QGuiApplication *app = SailfishApp::application(argc, argv);
    QQuickView *view = SailfishApp::createView();
    view->setSource(SailfishApp::pathTo("qml/harbour-qmlcreator.qml"));
    qmlRegisterType<DocumentHandler>("eekkelund.documenthandler", 1, 0, "DocumentHandler");
    view->showFullScreen();

    return app->exec();

}

