TEMPLATE = aux

OTHER_FILES = *.qml \
*.png \
*.svg

qml.files = $${OTHER_FILES}
qml.path = /usr/share/maliit/plugins/com/jolla/tide/

INSTALLS += qml
