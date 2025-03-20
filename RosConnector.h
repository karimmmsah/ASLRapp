#ifndef ROSCONNECTOR_H
#define ROSCONNECTOR_H

#include <QObject>
#include <QtWebSockets/QWebSocket>
#include <QDebug>

class RosConnector : public QObject {
    Q_OBJECT
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY connectionStatusChanged)

public:
    explicit RosConnector(QObject *parent = nullptr);

    Q_INVOKABLE void connectToRos();
    bool isConnected() const { return m_isConnected; }

signals:
    void connectedToRos();
    void connectionFailed();
    void connectionStatusChanged();

private slots:
    void onConnected();
    void onDisconnected();

private:
    QWebSocket webSocket;
    bool m_isConnected = false;
};

#endif // ROSCONNECTOR_H
