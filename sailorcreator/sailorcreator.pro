TARGET = harbour-sailorcreator

CONFIG += sailfishapp

SOURCES += src/harbour-sailorcreator.cpp \
    src/realhighlighter.cpp \
    src/documenthandler.cpp \
    src/iconprovider.cpp

OTHER_FILES += qml/harbour-sailorcreator.qml \
    qml/cover/CoverPage.qml \
    qml/pages/CreateProject.qml \
    qml/pages/ProjectHome.qml \
    qml/pages/CreatorHome.qml \
    translations/*.ts \
    harbour-sailorcreator.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

CONFIG += sailfishapp_i18n

TRANSLATIONS += translations/harbour-sailorcreator-de.ts

DISTFILES += \
    qml/pages/python/createProject.py \
    qml/pages/python/startProject.py \
    qml/pages/python/openFile.py \
   # qml/pages/Editor.qml \
    qml/pages/python/editFile.py \
    #qml/pages/AddFile.qml \
    qml/pages/python/addFile.py \
    #qml/pages/CreateProject2.qml \
    #qml/pages/AddFile2.qml \
    qml/pages/AddFileDialog.qml \
    #qml/pages/CreateProjectDialog.qml \
    qml/pages/AppOutput.qml \
    qml/pages/python/stopProject.py \
    qml/pages/Editor2.qml \
    qml/pages/RestoreDialog.qml \
    qml/pages/python/buildRPM.py \
    qml/pages/BuildOutput.qml


HEADERS += \
    src/realhighlighter.h \
    src/documenthandler.h \
    src/iconprovider.h

RESOURCES += \
    src/dictionarys.qrc
