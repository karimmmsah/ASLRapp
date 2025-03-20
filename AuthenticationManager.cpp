#include "AuthenticationManager.h"
#include <QJsonObject>
#include <QJsonDocument>
#include <QSettings>
#include <QDebug>

AuthenticationManager::AuthenticationManager(QObject *parent) : QObject(parent) {
    networkManager = new QNetworkAccessManager(this);

    QSettings settings("config.ini", QSettings::IniFormat);
    firebaseApiKey = settings.value("Firebase/API_KEY").toString();

    if (firebaseApiKey.isEmpty()) {
        qWarning() << "API Key is missing! Please check config.ini";
    }
}

void AuthenticationManager::loginUser(const QString &email, const QString &password) {
    if (firebaseApiKey.isEmpty()) {
        emit loginFailed("Missing API Key!");
        return;
    }

    QUrl url("https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=" + firebaseApiKey);
    QNetworkRequest request(url);
    request.setHeader(QNetworkRequest::ContentTypeHeader, "application/json");

    QJsonObject json;
    json["email"] = email;
    json["password"] = password;
    json["returnSecureToken"] = true;

    QJsonDocument jsonDoc(json);
    QByteArray jsonData = jsonDoc.toJson();

    QNetworkReply *reply = networkManager->post(request, jsonData);

    QObject::connect(reply, &QNetworkReply::finished, [=]() {
        QByteArray responseData = reply->readAll();
        QJsonDocument jsonResponse = QJsonDocument::fromJson(responseData);
        QJsonObject jsonObject = jsonResponse.object();

        if (reply->error() == QNetworkReply::NoError && jsonObject.contains("idToken")) {
            QString idToken = jsonObject["idToken"].toString();
            QString refreshToken = jsonObject["refreshToken"].toString();

            QSettings settings("ASU", "ASLR");
            settings.setValue("idToken", idToken);
            settings.setValue("refreshToken", refreshToken);

            qDebug() << "Login successful!";
            emit loginSuccess();
        } else {
            QString errorMessage = jsonObject["error"].toObject()["message"].toString();
            qDebug() << "Login failed: " << errorMessage;
            emit loginFailed(errorMessage);
        }
        reply->deleteLater();
    });
}
