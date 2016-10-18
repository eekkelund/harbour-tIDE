#ifndef SETTINGS_H
#define SETTINGS_H

#include <QQuickItem>

class Settings : public QQuickItem
{

    Q_OBJECT

public slots:
    void save(QString name, QString data);
    void restart();
    void backup();
    void restore();

public:
    Q_INVOKABLE QVariant load(QString name);
    Settings(QQuickItem *parent=0);
};


#endif // SETTINGS_H
