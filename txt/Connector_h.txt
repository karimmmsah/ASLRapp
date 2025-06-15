#ifndef ROSCONNECTOR_H
#define ROSCONNECTOR_H

#include <QObject>
#include <QtWebSockets/QWebSocket>
#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonArray>

class RosConnector : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY connectionStatusChanged)

public:
    explicit RosConnector(QObject *parent = nullptr);
    void onMessageReceived(const QString &message);
    bool isConnected() const { return m_isConnected; }
    Q_INVOKABLE void connectToRos();
    Q_INVOKABLE void goToChargingStation();
    Q_INVOKABLE void sendMessage(const QString &message);
    Q_INVOKABLE void sendGoal(double x, double y, double yaw);
    Q_INVOKABLE void setRosIp(const QString &ip);

signals:
    void connectedToRos();
    void connectionFailed();
    void connectionStatusChanged();
    void poseReceived(const QString &json);
    void mapReceived(const QString &json);
    void globalPathReceived(const QString &json);
    void localPathReceived(const QString &json);
    void goalReceived(const QString &json);
    void costmapReceived(const QString &json);
    void cmdVelReceived(const QString &twistJson);
    void hoverboardCmdVelReceived(const QString &twistJson);
    void batteryVoltageReceived(const QString &voltageJson);

private slots:
    void onConnected();
    void onDisconnected();

private:
    void subscribeToTopics();
    QWebSocket webSocket;
    bool m_isConnected = false;
    QString m_rosIp = "192.168.1.50";
};

#endif // ROSCONNECTOR_H
