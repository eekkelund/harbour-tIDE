#ifndef SRC_H
#define SRC_H

#include <QQmlExtensionPlugin>

class src : public QQmlExtensionPlugin
{
    Q_OBJECT
    Q_PLUGIN_METADATA(IID "org.qt-project.Qt.QQmlExtensionInterface")

public:
    void registerTypes(const char *uri);
};

#endif // SRC_H
