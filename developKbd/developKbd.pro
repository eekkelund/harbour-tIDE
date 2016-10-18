TEMPLATE = aux

OTHER_FILES = *.qml \
           develop.conf

qml.files = $${OTHER_FILES}
qml.path = /usr/share/maliit/plugins/com/jolla/layouts/

INSTALLS += qml

DISTFILES += \
    Xt9Handler.qml
