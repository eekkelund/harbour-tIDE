TEMPLATE = subdirs

SUBDIRS += \
    kbdsrc \
    developkbd \
    dolphin \
    config \
    tide \
    roothelper

OTHER_FILES += \
    rpm/harbour-tide.spec \
    rpm/harbour-tide.changes \
    harbour-tide.desktop

desktop.files =  harbour-tide.desktop
desktop.path =  /usr/share/applications/

INSTALLS += desktop

