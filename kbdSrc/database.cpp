#include "database.h"



Database::~Database()
{

}

QString Database::name() const
{
    return m_name;
}

void Database::setName(QString name)
{
    m_name = name;
}

/*void Database::directoryChanged(const QString & path)
{
    printf("sad");
    qDebug() << path;
    QSettings settings(QString(path), QSettings::IniFormat);
    QString someValue = settings.value("fileType/type", "default value if unset").toString(); // settings.value() returns QVariant
    qDebug() << someValue;
}

void Database::fileChanged(const QString & path)
{
    printf("path");
    qDebug() << path;
    QFileInfo checkFile(path);
    QSettings settings(QString(path), QSettings::IniFormat);
    QString someValue = settings.value("fileType/type", "default value if unset").toString(); // settings.value() returns QVariant
    qDebug() << someValue;
    while(!checkFile.exists()){}
    //std::this_thread::sleep_for(std::chrono::milliseconds(10));
    watcher->addPath(path);
}*/


Database::Database(QQuickItem *parent)
    : QQuickItem(parent)
{
    FileWatcher *fs = new FileWatcher();
    connect(fs, SIGNAL(changed(QString)), this, SLOT(changed(QString)));

    //watcher =0;
    //watcher = new QFileSystemWatcher(this);
    //connect(watcher, SIGNAL(fileChanged(const QString &)), this, SLOT(fileChanged(const QString &)));
    //connect(watcher, SIGNAL(directoryChanged(const QString &)), SLOT(directoryChanged(const QString &)));
    //watcher->addPath("/var/lib/harbour-sailorcreator-keyboard/config/config.conf");
    //watcher->addPath("/var/lib/harbour-sailorcreator-keyboard/config/");
    //printf("watcher");
   /* if ( database.database(m_name).isValid() == false ) {
        database = QSqlDatabase::addDatabase("QSQLITE", m_name);
    } else {
        database = QSqlDatabase::database(m_name);
    }

    database.setConnectOptions("QSQLITE_ENABLE_SHARED_CACHE = 1;");
    database.setDatabaseName("/var/lib/harbour-sailorcreator-keyboard/database/" + m_name + ".sqlite");
    qDebug()<<database.databaseName();
    QFileInfo fi("/var/lib/harbour-sailorcreator-keyboard/database/" + m_name + ".sqlite");
    if(QFile::exists("/var/lib/harbour-sailorcreator-keyboard/database/" + m_name + ".sqlite")) {
        qDebug() << fi.filePath();
    }


    database.open();
    qDebug() << database.lastError();

    QSqlQuery query(database);
    qDebug() << query.lastError();

    query.exec("PRAGMA synchronous = OFF; PRAGMA journal_mode = OFF; PRAGMA default_cache_size =32768; PRAGMA foreign_keys = OFF; PRAGMA count_changes = OFF; PRAGMA temp_store = qvectorMEMORY");
    qDebug() << query.lastError();
*/
}


void Database::initial(QString name)
{
    if ( database.database(name).isValid() == false ) {
        //database = QSqlDatabase::addDatabase("QSQLITE", name);
    } else {
        database = QSqlDatabase::database(name);
    }

    database.setConnectOptions("QSQLITE_ENABLE_SHARED_CACHE = 1;");
    database.setDatabaseName("/var/lib/harbour-sailorcreator-keyboard/database/" + name + ".sqlite");
    qDebug()<<database.databaseName();
    QFileInfo fi("/var/lib/harbour-sailorcreator-keyboard/database/" + name + ".sqlite");
    if(QFile::exists("/var/lib/harbour-sailorcreator-keyboard/database/" + name + ".sqlite")) {
        qDebug() << fi.filePath();
    }


    database.open();
    qDebug() << database.lastError();

    QSqlQuery query(database);
    qDebug() << query.lastError();

    query.exec("PRAGMA synchronous = OFF; PRAGMA journal_mode = OFF; PRAGMA default_cache_size =32768; PRAGMA foreign_keys = OFF; PRAGMA count_changes = OFF; PRAGMA temp_store = qvectorMEMORY");
    qDebug() << query.lastError();

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

void Database::debug(QString sql)
{
    QSqlQuery query(database);
    query.exec(sql);



    qDebug() << query.lastError();
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

void Database::changed(QString type)
{
    initial(type);
}



void Database::output(QString sql)
{

    QString result;
    QSqlQuery query(database);

    query.setForwardOnly(true);

    if( query.exec(sql)) {
        while (query.next()) {
            result += query.value(0).toString() + ", " + query.value(1).toInt() + "\n";
        }
    }

    QDir dir;
    QFile *file = new QFile(dir.homePath() + "/Dolphin/" + "user.txt");
    file->open(QFile::Append);

    QFile data(dir.homePath() + "/Dolphin/" + "user.txt");

    if (data.open(QFile::WriteOnly | QFile::Truncate)) {
        QTextStream out(&data);
        out.setCodec("UTF-8");
        out << result;

    }


}



QStringList Database::develop(QString keys, QString size)
{
    QString sql;

    sql = "SELECT word FROM predict WHERE keys GLOB \"" + keys + "*\" ORDER BY frequency DESC, sorting DESC LIMIT 0, " + size;

    return Database::load(sql);

}


QStringList Database::predict(QString word, QString size)
{
    QString sql;
    int prefix = word.length() + 1;
    //sql = "SELECT SUBSTR(word," + QString::number(prefix) + ") FROM predict WHERE word GLOB \"" + word + "*\" AND LENGTH(word) - " + QString::number(prefix) + " >= 0 ORDER BY frequency DESC, sorting DESC LIMIT 0, " + size;
    sql = "SELECT word FROM predict WHERE word GLOB \"" + word + "*\" AND LENGTH(word) - " + QString::number(prefix) + " >= 0 ORDER BY frequency DESC, sorting DESC LIMIT 0, " + size;
    return Database::load(sql);

}

