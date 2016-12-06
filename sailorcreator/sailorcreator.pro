TARGET = harbour-sailorcreator

CONFIG += sailfishapp

DEFINES += APP_VERSION=\"\\\"$${VERSION}\\\"\"

SOURCES += src/harbour-sailorcreator.cpp \
    src/realhighlighter.cpp \
    src/documenthandler.cpp \
    src/iconprovider.cpp

OTHER_FILES += qml/harbour-sailorcreator.qml \
    qml/cover/CoverPage.qml \
    qml/pages/CreateProject.qml \
    qml/pages/ProjectHome.qml \
    qml/pages/CreatorHome.qml \
    qml/pages/AddFileDialog.qml \
    qml/pages/AppOutput.qml \
    qml/pages/Editor2.qml \
    qml/pages/RestoreDialog.qml \
    qml/pages/BuildOutput.qml \
    qml/pages/MainPage.qml \
    qml/pages/FileManagerPage.qml \
    qml/pages/SettingsPage.qml \
    translations/*.ts \
    harbour-sailorcreator.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-sailorcreator-de.ts

DISTFILES += \
    qml/python/createProject.py \
    qml/python/startProject.py \
    qml/python/openFile.py \
    qml/python/editFile.py \
    qml/python/addFile.py \
    qml/python/stopProject.py \
    qml/python/buildRPM.py \
    qml/python/settings.py

HEADERS += \
    src/realhighlighter.h \
    src/documenthandler.h \
    src/iconprovider.h

RESOURCES += \
    src/dictionarys.qrc
