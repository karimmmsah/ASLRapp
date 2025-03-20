import QtQuick
import QtQuick.Controls

Window {
    id: root
    visible: true
    visibility: Window.FullScreen
    title: qsTr("ASLR Control Panel")

    Image {
        id: background
        opacity: 1
        visible: true
        source: "file:///D:/Downloads/A_Warehouse.jpg"
        focus: false
        antialiasing: true
        mirror: false
        fillMode: Image.Stretch
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0

        Text {
            x: 239
            y: 640
            width: 615
            height: 60
            text: "ASLR Control Panel"
            elide: Text.ElideNone
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: -54
            anchors.bottomMargin: 0
            font.pixelSize: 42
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            wrapMode: Text.WordWrap
            font.hintingPreference: Font.PreferDefaultHinting
            styleColor: "#423ea3"
            style: Text.Sunken
            font.capitalization: Font.AllUppercase
            textFormat: Text.AutoText
            font.italic: false
            font.weight: Font.Bold
            font.family: "Tahoma"
            font.bold: true
            color: "#000000"
        }

        Button {
            id: connectButton
            text: "Connect"
            width: 150
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter
            font.pixelSize: 22

            background: Rectangle {
                color: "#008080"
                radius: 10
            }

            contentItem: Text {
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.styleName: "Bold"
                font.family: "Tahoma"
                font.bold: true
                color: "white"
                text: "CONNECT"
                anchors.centerIn: parent
            }

            onClicked: stackView.push("LoginPage.qml")
        }

        Button {
            id: exitButton
            text: "Exit"
            width: 150
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: connectButton.bottom
            anchors.topMargin: 20
            font.pixelSize: 22

            background: Rectangle {
                color: "#D32F2F"
                radius: 10
            }

            contentItem: Text {
                font.pixelSize: 20
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.italic: false
                font.bold: true
                font.family: "Tahoma"
                color: "white"
                text: "EXIT"
                anchors.fill: parent
            }

            onClicked: Qt.quit()
        }

        Image {
            id: image
            width: 161
            height: 133
            opacity: 1
            visible: true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 10
            source: "file:///D:/Downloads/ASU.png"
            clip: false
            fillMode: Image.PreserveAspectFit
            z:1
        }
    }
}
