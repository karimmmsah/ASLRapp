#include "RosConnector.h"

RosConnector::RosConnector(QObject *parent) : QObject(parent) {
    connect(&webSocket, &QWebSocket::connected, this, &RosConnector::onConnected);
    connect(&webSocket, &QWebSocket::disconnected, this, &RosConnector::onDisconnected);
}

void RosConnector::connectToRos() {
    qDebug() << "Attempting to connect to ROS...";
    webSocket.open(QUrl("ws://192.168.1.29:9090"));
}

void RosConnector::onConnected() {
    qDebug() << "Connected to ROS!";
    m_isConnected = true;
    emit connectedToRos();
    emit connectionStatusChanged();

    // Topics
    sendMessage(R"({"op": "subscribe", "topic": "/hoverboard/connected", "type": "std_msgs/Bool"})");
    sendMessage(R"({"op": "subscribe", "topic": "/hoverboard/battery_voltage", "type": "std_msgs/Float64"})");
}

void RosConnector::onDisconnected() {
    qDebug() << "Disconnected from ROS!";
    m_isConnected = false;
    emit connectionFailed();
    emit connectionStatusChanged();
}

void RosConnector::sendMessage(const QString &message) {
    if (m_isConnected && webSocket.isValid()) {
        qDebug() << "Sending message to ROS:" << message;
        webSocket.sendTextMessage(message);
    } else {
        qDebug() << "WebSocket not connected. Message not sent.";
    }
}
