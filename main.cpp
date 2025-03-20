#include <QApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include <QQmlContext>
#include <QNetworkAccessManager>
#include <QNetworkRequest>
#include <QNetworkReply>
#include <QJsonDocument>
#include <QJsonObject>
#include <QDebug>
#include <QSettings>
#include <QFile>
#include "AuthenticationManager.h"
#include "RosConnector.h"

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);
    app.setWindowIcon(QIcon(":/Images/Icon.png"));

    QCoreApplication::setOrganizationName("ASU");
    QCoreApplication::setApplicationName("ASLR");

    QQmlApplicationEngine engine;

    AuthenticationManager authManager;
    RosConnector rosConnector;

    engine.rootContext()->setContextProperty("authManager", &authManager);
    engine.rootContext()->setContextProperty("rosConnector", &rosConnector);

    QString qmlFilePath = "C:/Users/HP/Documents/Qt/FrontEnd/Main.qml";

    QFile qmlFile(qmlFilePath);
    if (!qmlFile.exists()) {
        qDebug() << "ERROR: Main.qml not found!";
        return -1;
    }

    const QUrl url = QUrl::fromLocalFile(qmlFilePath);
    qDebug() << "Loading QML file from: " << url.toString();
    engine.load(url);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [](QObject *obj, const QUrl &) {
            if (!obj) QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);

    if (engine.rootObjects().isEmpty()) return -1;

    return app.exec();
}
