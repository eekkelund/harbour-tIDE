
TEMPLATE = subdirs

SUBDIRS += \
    kbdSrc \
    developKbd \
    dolphin \
    config \
    tide

OTHER_FILES += \
    rpm/harbour-tide.changes.in \
    rpm/harbour-tide.spec \
    rpm/harbour-tide.yaml \
