#include "database.h"

QString path = "/var/lib/harbour-sailorcreator-keyboard/database/";

Database::~Database()
{

}

Database::Database(QQuickItem *parent)
    : QQuickItem(parent)
{
    FileWatcher *fs = new FileWatcher();
    connect(fs, SIGNAL(changed(QString)), this, SLOT(changed(QString)));
}


void Database::initial(QString name)
{
    //If should use properties
    if (name != "qml" && name != "js" && name != "py") {
        name = "properties";
    }
    //Check if file exists
    if(QFile::exists(path + name + ".sqlite")) {
        if ( database.database(name).isValid() == false ) {
            database = QSqlDatabase::addDatabase("QSQLITE", name);
        } else {
            database = QSqlDatabase::database(name);
        }
        //open database
        database.setConnectOptions("QSQLITE_ENABLE_SHARED_CACHE = 1;");
        database.setDatabaseName("/var/lib/harbour-sailorcreator-keyboard/database/" + name + ".sqlite");
        database.open();
        QSqlQuery query(database);
        query.exec("PRAGMA synchronous = OFF; PRAGMA journal_mode = OFF; PRAGMA default_cache_size =32768; PRAGMA foreign_keys = OFF; PRAGMA count_changes = OFF; PRAGMA temp_store = qvectorMEMORY");
    }

}


QStringList Database::load(QString sql)
{
    QList<QString> temp;

    QSqlQuery query(database);
    query.setForwardOnly(true);

    if( query.exec(sql)) {

        while (query.next()) {
            temp << query.value(0).toString();
        }

    }

    return temp;

}

void Database::update(QString sql)
{

    QSqlQuery query(database);
    query.setForwardOnly(true);
    query.exec(sql);

}

void Database::adjust(QString name, QString word)
{
    QString sql;
    sql = "UPDATE " + name + " SET frequency = frequency + 1 WHERE word = \"" + word + "\"";

    QSqlQuery query(database);
    query.exec(sql);
}

void Database::close(QString name)
{
    //Check database connection exist or not
    if ( database.database(name).isValid() == true ) {
        database = QSqlDatabase::database(name);
        database.close();

    }
}

void Database::index(QString name)
{
    if ( database.database(name).isValid() == true ) {
        database = QSqlDatabase::database(name);
        database.exec("REINDEX");

    }
}

//Slot if fileType is changed in config.conf
void Database::changed(QString type)
{
    initial(type);
}



QStringList Database::develop(QString keys, QString size)
{
    QString sql;

    sql = "SELECT word FROM predict WHERE keys GLOB \"" + keys + "*\" ORDER BY frequency DESC, sorting DESC LIMIT 0, " + size;

    return Database::load(sql);

}

//prediction call
QStringList Database::predict(QString word, QString size)
{
    QString sql;
    int prefix = word.length() + 1;
    sql = "SELECT word FROM predict WHERE word GLOB \"" + word + "*\" AND LENGTH(word) - " + QString::number(prefix) + " >= 0 ORDER BY frequency DESC, sorting DESC LIMIT 0, " + size;
    return Database::load(sql);

}

