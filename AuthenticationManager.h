#ifndef AUTHENTICATIONMANAGER_H
#define AUTHENTICATIONMANAGER_H

#define FIREBASE_API_KEY "AIzaSyA-Bf9fFQy9qev11pzQRt3CVd_VpVCsbkM"

#include <QObject>
#include <QString>
#include <QNetworkAccessManager>
#include <QNetworkReply>

class AuthenticationManager : public QObject {
    Q_OBJECT
public:
    explicit AuthenticationManager(QObject *parent = nullptr);
    Q_INVOKABLE void loginUser(const QString &email, const QString &password);

signals:
    void loginSuccess();
    void loginFailed(const QString &errorMessage);

private:
    QNetworkAccessManager *networkManager;
    QString firebaseApiKey;
};

#endif // AUTHENTICATIONMANAGER_H
