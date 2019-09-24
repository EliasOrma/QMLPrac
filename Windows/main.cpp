#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlEngine>
#include <QQmlContext>

#include "windowcontrol.hh"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc,argv);
    QQmlApplicationEngine engine;

    QQmlContext* context = engine.rootContext();
    WindowControl cppobject;
    context->setContextProperty("wcontrol", &cppobject);

    engine.load(QUrl(QStringLiteral("qrc:/windowsfront.qml")));
    if(engine.rootObjects().isEmpty())
    {
        return 0;
    }
    return app.exec();
}
