TARGET = template

CONFIG += sailfishapp

OTHER_FILES += qml/template.qml \
    qml/cover/CoverPage.qml \
    qml/pages/FirstPage.qml \
    qml/pages/SecondPage.qml \
    rpm/template.changes.in \
    rpm/template.spec \
    translations/*.ts \
    template.desktop

SAILFISHAPP_ICONS = 86x86 108x108 128x128 256x256


CONFIG += sailfishapp_i18n


TRANSLATIONS += translations/template.ts

DISTFILES += \
    qml/pages/button.py
