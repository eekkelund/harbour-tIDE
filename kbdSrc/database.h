#ifndef DATABASE_H
#define DATABASE_H
#include <QSqlDatabase>
#include <QQuickItem>
#include <QStringList>
#include <QVariantList>
#include <QMap>

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

private:

    QString m_name;

};


#endif // DATABASE_H
