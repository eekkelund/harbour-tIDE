#ifndef ICONPROVIDER_H
#define ICONPROVIDER_H

#include <sailfishapp.h>
#include <QQuickImageProvider>
#include <QPainter>
#include <QColor>

class IconProvider : public QQuickImageProvider
{
public:
    IconProvider();
    QPixmap requestPixmap(const QString &id, QSize *size, const QSize &requestedSize);
};

#endif // ICONPROVIDER_H
