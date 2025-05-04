#ifndef AUTHENTICATIONMANAGER_H
#define AUTHENTICATIONMANAGER_H

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
