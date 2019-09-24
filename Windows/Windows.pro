TEMPLATE = app
CONFIG += console c++11
QT       += core gui
QT += qml quick

SOURCES += \
        main.cpp \
    windowcontrol.cpp

DISTFILES += \
    windowsfront.qml \
    rect.qml

HEADERS += \
    windowcontrol.hh

RESOURCES += \
    qml.qrc
