TEMPLATE = lib
TARGET = harbour-sailorcreator
QT += qml quick sql
CONFIG += qt plugin

TARGET = $$qtLibraryTarget($$TARGET)
uri = harbour.sailorcreator.keyboard

# Input
SOURCES += \
    database.cpp \
    src.cpp \
    settings.cpp \
    filewatcher.cpp


HEADERS += \
    database.h \
    src.h \
    settings.h \
    filewatcher.h

OTHER_FILES = qmldir

## Install
installPath = $$[QT_INSTALL_QML]/$$replace(uri, \\., /)

qmldir.files = qmldir
qmldir.path = $$installPath
target.path = $$installPath
INSTALLS += target qmldir
