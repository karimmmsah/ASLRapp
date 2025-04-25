#include "RosConnector.h"

RosConnector::RosConnector(QObject *parent) : QObject(parent) {
    connect(&webSocket, &QWebSocket::connected, this, &RosConnector::onConnected);
    connect(&webSocket, &QWebSocket::disconnected, this, &RosConnector::onDisconnected);
    connect(&webSocket, &QWebSocket::textMessageReceived, this, &RosConnector::onMessageReceived);
}

void RosConnector::connectToRos() {
    qDebug() << "Attempting to connect to ROS...";
    webSocket.open(QUrl("ws://192.168.1.21:9090"));
}

void RosConnector::onConnected() {
    qDebug() << "Connected to ROS!";
    m_isConnected = true;
    emit connectedToRos();
    emit connectionStatusChanged();

    subscribeToTopics();
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

void RosConnector::subscribeToTopics() {
    auto subscribe = [this](const QString &topic, const QString &type) {
        QJsonObject obj;
        obj["op"] = "subscribe";
        obj["topic"] = topic;
        obj["type"] = type;
        webSocket.sendTextMessage(QJsonDocument(obj).toJson());
    };

    // Battery & Status
    subscribe("/hoverboard/connected", "std_msgs/Bool");
    subscribe("/hoverboard/battery_voltage", "std_msgs/Float64");

    // Navigation / Map
    subscribe("/amcl_pose", "geometry_msgs/PoseWithCovarianceStamped");
    subscribe("/map", "nav_msgs/OccupancyGrid");
    subscribe("/move_base/GlobalPlanner/plan", "nav_msgs/Path");
    subscribe("/move_base/DWAPlannerROS/local_plan", "nav_msgs/Path");
}

void RosConnector::onMessageReceived(const QString &message) {
    QJsonDocument doc = QJsonDocument::fromJson(message.toUtf8());

    if (!doc.isObject()) {
        qDebug() << "Invalid JSON message received.";
        return;
    }

    QJsonObject obj = doc.object();
    QString topic = obj["topic"].toString();

    if (topic == "/hoverboard/connected" || topic == "/hoverboard/battery_voltage") {
        onMessageReceived(message);
        return;
    }

    if (topic == "/amcl_pose") {
        QJsonObject pose = obj["msg"].toObject()["pose"].toObject()["pose"].toObject();
        emit poseReceived(QJsonDocument(pose).toJson(QJsonDocument::Compact));
    } else if (topic == "/map") {
        QJsonObject msg = obj["msg"].toObject();
        emit mapReceived(QJsonDocument(msg).toJson(QJsonDocument::Compact));
    } else if (topic == "/move_base/GlobalPlanner/plan") {
        QJsonArray poses = obj["msg"].toObject()["poses"].toArray();
        emit globalPathReceived(QJsonDocument(poses).toJson(QJsonDocument::Compact));
    } else if (topic == "/move_base/DWAPlannerROS/local_plan") {
        QJsonArray poses = obj["msg"].toObject()["poses"].toArray();
        emit localPathReceived(QJsonDocument(poses).toJson(QJsonDocument::Compact));
    }
}
