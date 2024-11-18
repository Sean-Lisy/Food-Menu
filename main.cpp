#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "qfoodmeun.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    // qmlRegisterType<QFoodMeun>("MyCppObject", 1, 0, "QFoodMeun");
    QQmlApplicationEngine engine;
    QFoodMeun foodMenu1;
    engine.rootContext()->setContextProperty("foodMenu", &foodMenu1);
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("Food-Menu", "Main");

    return app.exec();
}
