#include "RosConnector.h"

RosConnector::RosConnector(QObject *parent) : QObject(parent) {
    connect(&webSocket, &QWebSocket::connected, this, &RosConnector::onConnected);
    connect(&webSocket, &QWebSocket::disconnected, this, &RosConnector::onDisconnected);
    connect(&webSocket, &QWebSocket::textMessageReceived, this, &RosConnector::onMessageReceived);
}

void RosConnector::connectToRos() {
    qDebug() << "Attempting to connect to ASLR at" << m_rosIp;
    webSocket.open(QUrl("ws://" + m_rosIp + ":9090"));
}

void RosConnector::setRosIp(const QString &ip) {
    m_rosIp = ip;
    qDebug() << "Updated ROS IP to:" << m_rosIp;
}

void RosConnector::onConnected() {
    qDebug() << "Connected to ASLR!";
    m_isConnected = true;
    emit connectedToRos();
    emit connectionStatusChanged();
    subscribeToTopics();
}

void RosConnector::onDisconnected() {
    qDebug() << "Disconnected from ASLR!";
    m_isConnected = false;
    emit connectionFailed();
    emit connectionStatusChanged();
}

void RosConnector::sendMessage(const QString &message) {
    if (m_isConnected && webSocket.isValid()) {
        qDebug() << "Sending message to ASLR:" << message;
        webSocket.sendTextMessage(message);
    } else {
        qDebug() << "ASLR not connected. Message not sent.";
    }
}

void RosConnector::subscribeToTopics() {
    if (!m_isConnected || !webSocket.isValid()) {
        qDebug() << "WebSocket is not valid or not connected.";
        return;
    }

    auto subscribe = [this](const QString &topic, const QString &type) {
        QJsonObject obj;
        obj["op"] = "subscribe";
        obj["topic"] = topic;
        obj["type"] = type;
        webSocket.sendTextMessage(QJsonDocument(obj).toJson());
    };

    // Motor
    subscribe("/cmd_vel", "geometry_msgs/Twist");
    subscribe("/hoverboard_velocity_controller/cmd_vel", "geometry_msgs/Twist");

    // Battery
    subscribe("/hoverboard/battery_voltage", "std_msgs/Float64");

    // Navigation & Map
    subscribe("/amcl_pose", "geometry_msgs/PoseWithCovarianceStamped");
    subscribe("/map", "nav_msgs/OccupancyGrid");
    subscribe("/move_base/DWAPlannerROS/local_plan", "nav_msgs/Path");
    subscribe("/move_base/NavfnROS/plan", "nav_msgs/Path");
    subscribe("/move_base_simple/goal", "geometry_msgs/PoseStamped");
    //subscribe("/move_base/GlobalPlanner/plan", "nav_msgs/Path");
}

void RosConnector::onMessageReceived(const QString &message) {
    QJsonDocument doc = QJsonDocument::fromJson(message.toUtf8());

    if (!doc.isObject()) {
        qDebug() << "Invalid JSON message received.";
        return;
    }

    QJsonObject obj = doc.object();
    QString topic = obj["topic"].toString();

    if (topic == "/amcl_pose") {
        QJsonObject pose = obj["msg"].toObject()["pose"].toObject()["pose"].toObject();
        emit poseReceived(QJsonDocument(pose).toJson(QJsonDocument::Compact));
    } else if (topic == "/map") {
        QJsonObject msg = obj["msg"].toObject();
        emit mapReceived(QJsonDocument(msg).toJson(QJsonDocument::Compact));
    } else if (topic == "/move_base/NavfnROS/plan") {
        QJsonArray poses = obj["msg"].toObject()["poses"].toArray();
        emit globalPathReceived(QJsonDocument(poses).toJson(QJsonDocument::Compact));
    } else if (topic == "/move_base_simple/goal") {
        QJsonObject pose = obj["msg"].toObject()["pose"].toObject();
        emit goalReceived(QJsonDocument(pose).toJson(QJsonDocument::Compact));
    } else if (topic == "/cmd_vel") {
        QJsonObject msg = obj["msg"].toObject();
        emit cmdVelReceived(QJsonDocument(msg).toJson(QJsonDocument::Compact));
    } else if (topic == "/hoverboard_velocity_controller/cmd_vel") {
        QJsonObject msg = obj["msg"].toObject();
        emit hoverboardCmdVelReceived(QJsonDocument(msg).toJson(QJsonDocument::Compact));
    } else if (topic == "/hoverboard/battery_voltage") {
        QJsonObject msg = obj["msg"].toObject();
        emit batteryVoltageReceived(QJsonDocument(msg).toJson(QJsonDocument::Compact));
    }
    else {
        qDebug() << "Unhandled topic:" << topic;
    }
}

void RosConnector::sendGoal(double x, double y) {
    QJsonObject message;
    message["op"] = "publish";
    message["topic"] = "/move_base_simple/goal";
    message["type"] = "geometry_msgs/PoseStamped";

    QJsonObject msg;
    QJsonObject header;
    header["frame_id"] = "map";
    msg["header"] = header;

    QJsonObject position;
    position["x"] = x;
    position["y"] = y;
    position["z"] = 0.0;

    QJsonObject orientation;
    orientation["x"] = 0.0;
    orientation["y"] = 0.0;
    orientation["z"] = 0.0;
    orientation["w"] = 1.0;

    QJsonObject pose;
    pose["position"] = position;
    pose["orientation"] = orientation;

    msg["pose"] = pose;
    message["msg"] = msg;

    QJsonDocument doc(message);
    sendMessage(QString::fromUtf8(doc.toJson(QJsonDocument::Compact)));
}

void RosConnector::goToChargingStation() {
    if (!m_isConnected) {
        qDebug() << "Not connected to ASLR!";
        return;
    }

    double x = 0;
    double y = 0;

    QJsonObject message;
    message["op"] = "publish";
    message["topic"] = "/move_base_simple/goal";
    message["type"] = "geometry_msgs/PoseStamped";

    QJsonObject msg;
    QJsonObject header;
    header["frame_id"] = "map";
    msg["header"] = header;

    QJsonObject position;
    position["x"] = x;
    position["y"] = y;
    position["z"] = 0.0;

    QJsonObject orientation;
    orientation["x"] = 0.0;
    orientation["y"] = 0.0;
    orientation["z"] = 0.0;
    orientation["w"] = 1.0;

    QJsonObject pose;
    pose["position"] = position;
    pose["orientation"] = orientation;

    msg["pose"] = pose;
    message["msg"] = msg;

    QJsonDocument doc(message);
    QString jsonMsg = QString::fromUtf8(doc.toJson(QJsonDocument::Compact));

    qDebug() << "Goal Sent:" << jsonMsg;

    sendMessage(jsonMsg);
}
