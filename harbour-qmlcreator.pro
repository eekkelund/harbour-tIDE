# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-qmlcreator

QT += widgets gui qml

CONFIG += sailfishapp

SOURCES += src/harbour-qmlcreator.cpp \
    src/realhighlighter.cpp \
    src/documenthandler.cpp

OTHER_FILES += qml/harbour-qmlcreator.qml \
    qml/cover/CoverPage.qml \
    qml/pages/CreateProject.qml \
    qml/pages/ProjectHome.qml \
    qml/pages/CreatorHome.qml \
    rpm/harbour-qmlcreator.changes.in \
    rpm/harbour-qmlcreator.spec \
    rpm/harbour-qmlcreator.yaml \
    translations/*.ts \
    harbour-qmlcreator.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n

# German translation is enabled as an example. If you aren't
# planning to localize your app, remember to comment out the
# following TRANSLATIONS line. And also do not forget to
# modify the localized app name in the the .desktop file.
TRANSLATIONS += translations/harbour-qmlcreator-de.ts

DISTFILES += \
    qml/pages/python/createProject.py \
    qml/pages/python/startProject.py \
    qml/pages/python/openFile.py \
    qml/pages/Editor.qml \
    qml/pages/python/editFile.py \
    qml/pages/AddFile.qml \
    qml/pages/python/addFile.py \
    src/dictionaries/javascript.txt \
    src/dictionaries/keywords.txt \
    src/dictionaries/properties.txt \
    src/dictionaries/qml.txt \
    qml/pages/CreateProject2.qml \
    qml/pages/AddFile2.qml \
    qml/pages/AddFileDialog.qml \
    qml/pages/CreateProjectDialog.qml \
    qml/pages/AppOutput.qml \
    qml/pages/launchProject.js \
    qml/pages/python/stopProject.py \
    qml/pages/Editor2.qml


HEADERS += \
    src/realhighlighter.h \
    src/documenthandler.h

RESOURCES += \
    src/dictionarys.qrc




