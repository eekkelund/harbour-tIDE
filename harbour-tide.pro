
TEMPLATE = subdirs

SUBDIRS += \
    kbdsrc \
    developkbd \
    dolphin \
    config \
    tide \
    roothelper

OTHER_FILES += \
    rpm/harbour-tide.changes.in \
    rpm/harbour-tide.spec
