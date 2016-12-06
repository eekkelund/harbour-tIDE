TEMPLATE = aux

OTHER_FILES = \
    config.conf

DISTFILES += \
    *.sqlite

sql.files = $${DISTFILES}
sql.path = /var/lib/harbour-tide-keyboard/database/

qml.files = $${OTHER_FILES}
qml.path = /var/lib/harbour-tide-keyboard/config/

INSTALLS += qml sql


