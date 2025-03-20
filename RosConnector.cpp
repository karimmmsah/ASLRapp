#include "RosConnector.h"

RosConnector::RosConnector(QObject *parent) : QObject(parent) {
    connect(&webSocket, &QWebSocket::connected, this, &RosConnector::onConnected);
    connect(&webSocket, &QWebSocket::disconnected, this, &RosConnector::onDisconnected);
}

void RosConnector::connectToRos() {
    qDebug() << "Attempting to connect to ROS...";
    webSocket.open(QUrl("ws://192.168.1.50:9090"));  // IP
}

void RosConnector::onConnected() {
    qDebug() << "Connected to ROS!";
    m_isConnected = true;
    emit connectedToRos();
    emit connectionStatusChanged();
}

void RosConnector::onDisconnected() {
    qDebug() << "Disconnected from ROS!";
    m_isConnected = false;
    emit connectionFailed();
    emit connectionStatusChanged();
}
