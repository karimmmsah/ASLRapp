// Imports
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs

// Main
Window {
    id: main
    visible: true
    visibility: Window.FullScreen
    title: qsTr("ASLR Control Panel")
    color: "#f8f9fA"
    // Connect Page
    Item {
        id: connectPage
        anchors.fill: parent
        visible: true
        // Background Image
        Image {
            id: background
            opacity: 1
            visible: true
            source: "qrc:/Images/A_Warehouse.jpg"
            antialiasing: true
            fillMode: Image.Stretch
            anchors.fill: parent
            anchors.leftMargin: 0
            anchors.rightMargin: 0
            anchors.topMargin: 0
            anchors.bottomMargin: 0
            // Title
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
            // Logo Image
            Image {
                width: 161
                height: 133
                opacity: 1
                visible: true
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: 0
                anchors.topMargin: 10
                source: "qrc:/Images/ASU.png"
                clip: false
                fillMode: Image.PreserveAspectFit
                z:1
            }
            // Shelves Logo
            Image {
                id: image
                y: 567
                width: 276
                height: 201
                anchors.left: parent.left
                anchors.bottom: parent.bottom
                anchors.leftMargin: 5
                anchors.bottomMargin: 5
                source: "qrc:Images/Icon.png"
                fillMode: Image.PreserveAspectFit
            }
            // Decorations
            Rectangle {
                x: 857
                width: 511
                height: 61
                opacity: 0.9
                color: "#ff9a00"
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: -2
                anchors.topMargin: 760
                z: -22
            }
            // Connect Button
            Button {
                id: connectButton
                text: "Connect"
                width: 150
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 22

                background: Rectangle {
                    color: rosConnector.isConnected ? "#4CAF50" : "#008080"
                    radius: 10
                }

                contentItem: Text {
                    font.pixelSize: 20
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.bold: true
                    color: "white"
                    text: rosConnector.isConnected ? "CONNECTED" : "CONNECT"
                }

                onClicked: {
                    rosConnector.connectToRos();
                }

                Connections {
                    target: rosConnector
                    function onConnectedToRos() {
                        console.log("Connected to ROS! Moving to login page.");
                        connectPage.visible = false;
                        loginPage.visible = true;
                    }

                    function onConnectionFailed() {
                        console.log("Connection to ROS failed!");
                    }
                }
            }
            // Exit Button
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
                    smooth: true
                    antialiasing: false
                    font.italic: false
                    font.bold: true
                    font.family: "Tahoma"
                    color: "white"
                    text: "EXIT"
                    anchors.fill: parent
                }

                onClicked: exitDialog.open()
            }
            // Exit Confirmation Dialog
            Dialog {
                id: exitDialog
                modal: true
                width: 340
                height: 160
                background: Rectangle {
                    color: "#F8F9FA"
                    radius: 10
                }

                x: (parent.width - width) / 2
                y: (parent.height - height) / 1.85

                contentItem: Column {
                    spacing: 25
                    anchors.fill: parent
                    anchors.margins: 30

                    Label {
                        text: "Are you sure you want to exit?"
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333333"
                        horizontalAlignment: Qt.AlignHCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Row {
                        spacing: 20
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.topMargin: 50
                        Button {
                            text: "Cancel"
                            width: 80
                            height: 40
                            background: Rectangle {
                                color: "#E0E0E0"
                                radius: 10
                            }
                            onClicked: exitDialog.close()
                        }

                        Button {
                            text: "Exit"
                            width: 80
                            height: 40
                            background: Rectangle {
                                color: "#D32F2F"
                                radius: 10
                            }
                            contentItem: Text {
                                text: "Exit"
                                color: "white"
                                font.bold: true
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }
                            onClicked:{
                                main.close()
                                console.log("App Terminated.")
                            }
                        }
                    }
                }
            }
        }
    }
    //--------------------------------------------------------------
    // Login Page
    Item {
        id: loginPage
        anchors.fill: parent
        visible: false
        // Title
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
        // Logo Image
        Image {
            width: 161
            height: 133
            opacity: 1
            visible: true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 10
            source: "qrc:/Images/ASU.png"
            clip: false
            fillMode: Image.PreserveAspectFit
            z:1
        }
        // Decorations
        Rectangle {
            x: 857
            width: 511
            height: 61
            opacity: 0.9
            color: "#434040"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: -2
            anchors.topMargin: 760
            z: -22
        }
        // Credentials
        Column {
            anchors.centerIn: parent
            spacing: 20
            // Username Field
            Rectangle {
                width: 280
                height: 50
                radius: 20
                color: "white"
                border.color: "#CCCCCC"
                border.width: 2
                clip: true

                TextField {
                    id: emailField
                    width: parent.width - 20
                    height: parent.height
                    anchors.centerIn: parent
                    placeholderText: "Email"
                    font.pixelSize: 20
                    leftPadding: 15
                    verticalAlignment: Text.AlignVCenter
                    color: "black"
                    background: Rectangle {
                        color: "transparent"
                        radius: 20
                    }
                }
            }
            // Password Field
            Rectangle {
                width: 280
                height: 50
                radius: 20
                color: "white"
                border.color: "#CCCCCC"
                border.width: 2
                clip: true

                TextField {
                    id: passwordField
                    width: parent.width - 20
                    height: parent.height
                    anchors.centerIn: parent
                    placeholderText: "Password"
                    font.pixelSize: 20
                    leftPadding: 15
                    verticalAlignment: Text.AlignVCenter
                    color: "black"
                    echoMode: TextInput.Password
                    background: Rectangle {
                        color: "transparent"
                        radius: 20
                    }

                    Keys.onReturnPressed: {
                        loginButton.clicked()
                    }
                }
            }
            // Login Button
            Button {
                id: loginButton
                text: "LOG IN"
                width: 160
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter

                background: Rectangle {
                    color: "#008080"
                    radius: 10
                }

                contentItem: Text {
                    text: parent.text
                    font.pixelSize: 22
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    font.family: "Tahoma"
                    font.bold: true
                    color: "white"
                }

                onClicked: {
                    if (emailField.text === "" || passwordField.text === "") {
                        loginerrorDialog.open();
                    } else {
                        authManager.loginUser(emailField.text, passwordField.text);
                    }
                }
            }
        }
        // Success and Error Handling
        Connections {
            target: authManager

            onLoginSuccess: {
                console.log("Login successful!");
                loginPage.visible = false;
                selectionPage.visible = true;
            }

            onLoginFailed: (errorMessage) => {
                               console.log("Login failed: " + errorMessage);
                               loginerrorDialog.open();
                           }
        }
        // Error Dialog
        Dialog {
            id: loginerrorDialog
            modal: true
            width: 340
            height: 160
            background: Rectangle {
                color: "#F8F9FA"
                radius: 10
            }

            x: (parent.width - width) / 2
            y: (parent.height - height) / 1.85

            contentItem: Column {
                spacing: 25
                anchors.fill: parent
                anchors.margins: 30

                Label {
                    id: errorMessageLabel
                    text: "Invalid username or password.\nPlease try again."
                    font.pixelSize: 16
                    font.bold: true
                    color: "#D32F2F"
                    horizontalAlignment: Qt.AlignHCenter
                    wrapMode: Text.WordWrap
                    anchors.horizontalCenter: parent.horizontalCenter
                }

                Row {
                    spacing: 20
                    anchors.horizontalCenter: parent.horizontalCenter
                    anchors.topMargin: 50

                    Button {
                        text: "OK"
                        width: 80
                        height: 40
                        background: Rectangle {
                            color: "#008080"
                            radius: 10
                        }
                        contentItem: Text {
                            text: "OK"
                            font.pixelSize: 16
                            font.bold: true
                            color: "white"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        onClicked: {
                            loginerrorDialog.close();
                            emailField.focus = true;
                        }
                    }
                }
            }
        }
        // Back Button
        Button {
            text: "Back"
            width: 80
            height: 40
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 20
            font.bold: false
            font.pointSize: 10
            font.family: "Tahoma"
            display: AbstractButton.TextOnly

            background: Rectangle {
                color: "#D32F2F"
                radius: 10
            }

            contentItem: Text {
                text: parent.text
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                color: "white"
                anchors.centerIn: parent
            }

            onClicked: {
                loginPage.visible = false
                connectPage.visible = true
            }
        }
    }

    //--------------------------------------------------------------
    // Selection Page
    Item {
        id: selectionPage
        anchors.fill: parent
        visible: false
        // Title
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
        // Logo Image
        Image {
            width: 161
            height: 133
            opacity: 1
            visible: true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 10
            source:"qrc:/Images/ASU.png"
            clip: false
            fillMode: Image.PreserveAspectFit
            z:1
        }
        // Decorations
        Rectangle {
            x: 857
            width: 511
            height: 61
            opacity: 0.9
            color: "#33dc23"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: -2
            anchors.topMargin: 760
            z: -22
        }
        // Toggle
        Item {
            anchors.centerIn: parent

            ColumnLayout {
                anchors.centerIn: parent
                spacing: 20

                Text {
                    text: "Select Control Type"
                    font.pixelSize: 26
                    font.bold: true
                    color: "#333333"
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    Layout.alignment: Qt.AlignHCenter
                }

                Rectangle {
                    id: controlToggle
                    width: 300
                    height: 60
                    radius: 30
                    color: "#DDDDDD"
                    border.color: "#BBBBBB"

                    property bool isAutomatic: true

                    RowLayout {
                        anchors.fill: parent
                        spacing: 0

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            radius: controlToggle.radius
                            color: controlToggle.isAutomatic ? "#008080" : "#DDDDDD"

                            Text {
                                text: "AUTOMATIC"
                                font.pixelSize: 18
                                font.bold: true
                                color: controlToggle.isAutomatic ? "white" : "black"
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    controlToggle.isAutomatic = true
                                    selectionPage.visible = false
                                    automaticControlPage.visible = true
                                }
                            }
                        }

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            radius: controlToggle.radius
                            color: controlToggle.isAutomatic ? "#DDDDDD" : "#008080"

                            Text {
                                text: "MANUAL"
                                font.pixelSize: 18
                                font.bold: true
                                color: controlToggle.isAutomatic ? "black" : "white"
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                anchors.fill: parent
                                onClicked: {
                                    controlToggle.isAutomatic = false
                                    selectionPage.visible = false
                                    manualControlPage.visible = true
                                }
                            }
                        }
                    }
                }
            }
        }
        // Sign Out Button
        Button {
            text: "Sign Out"
            width: 100
            height: 40
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 20
            font.bold: false
            font.pointSize: 10
            font.family: "Tahoma"
            display: AbstractButton.TextOnly

            background: Rectangle {
                color: "#D32F2F"
                radius: 10
            }

            contentItem: Text {
                text: parent.text
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                color: "white"
                anchors.centerIn: parent
            }

            onClicked: {
                selectionPage.visible = false
                loginPage.visible = true
                emailField.text = ""
                passwordField.text = ""
                console.log("Signed out.")
            }
        }
    }
    //--------------------------------------------------------------
    // Automatic Control
    Item {
        id: automaticControlPage
        anchors.fill: parent
        visible: false
        // Title
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
        // Logo Image
        Image {
            width: 161
            height: 133
            opacity: 1
            visible: true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 10
            source: "qrc:/Images/ASU.png"
            clip: false
            fillMode: Image.PreserveAspectFit
            z:1
        }
        // Decorations
        Rectangle {
            x: 857
            width: 511
            height: 61
            opacity: 0.9
            color: "#525ed4"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: -2
            anchors.topMargin: 760
            z: -22
        }
        // Status & Battery Display
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            spacing: 10

            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Status:"
                    font.pointSize: 16
                    font.bold: true
                    color: "black"
                }

                Label {
                    id: statusLabel
                    text: "Idle"
                    font.pointSize: 16
                    font.bold: true
                    color: "green"
                }
            }

            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Battery:"
                    font.pointSize: 14
                    font.bold: true
                    color: "black"
                }

                Label {
                    id: batteryPercentage
                    text: "75%"
                    font.pointSize: 14
                    font.bold: true
                    color: "green"
                }
            }

            Rectangle {
                width: 200
                height: 15
                radius: 5
                color: "#E0E0E0"
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    id: batteryBar
                    width: parent.width * 0.75
                    height: parent.height
                    radius: 5
                    color: "green"
                }
            }
        }
        // Camera & Map Feed
        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 180
            spacing: 30

            Rectangle {
                width: 500
                height: 300
                color: "#cccccc"
                Text {
                    anchors.centerIn: parent
                    text: "Camera Feed"
                    color: "black"
                }
            }

            Rectangle {
                width: 500
                height: 300
                color: "#cccccc"
                Text {
                    anchors.centerIn: parent
                    text: "Map"
                    color: "black"
                }
            }
        }
        // Pick & Drop
        Row {
            x: 450
            y: 500
            spacing: 100

            Column {
                spacing: 10

                Label {
                    text: "Pick:"
                    font.pointSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    font.italic: false
                    font.underline: true
                }

                ComboBox {
                    id: shelfDropdown
                    width: 170
                    height: 40
                    model: ["Shelf A", "Shelf B", "Shelf C"]

                    background: Rectangle {
                        color: "#434040"
                        radius: 8
                    }

                    contentItem: Text {
                        text: shelfDropdown.currentText
                        color: "white"
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    indicator: Rectangle {
                        width: 20
                        height: 20
                        radius: 5
                        color: "white"
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                    }
                }
            }

            Column {
                spacing: 10

                Label {
                    text: "Drop:"
                    font.pointSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    font.underline: true
                    font.italic: false
                }

                ComboBox {
                    id: locationDropdown
                    width: 170
                    height: 40
                    model: ["Location 1", "Location 2", "Location 3"]

                    background: Rectangle {
                        color: "#434040"
                        radius: 8
                    }

                    contentItem: Text {
                        text: locationDropdown.currentText
                        color: "white"
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    indicator: Rectangle {
                        width: 20
                        height: 20
                        radius: 5
                        color: "white"
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                    }
                }
            }
        }
        // QR Scan Button
        Button {
            y: 503
            text: "QR SCAN"
            anchors.left: parent.left
            width: 150
            height: 50
            anchors.bottom: parent.bottom
            anchors.leftMargin: 165
            anchors.bottomMargin: 215
            font.bold: true
            font.pointSize: 14

            background: Rectangle {
                color: "#1976D2"
                radius: 10
            }

            contentItem: Text {
                text: parent.text
                font.pixelSize: 18
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Tahoma"
            }

            onClicked: {
                console.log("QR Scan initiated!")
            }
        }
        // Execute Button
        Button {
            text: "Execute"
            width: 200
            height: 50
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 30
            font.bold: true
            font.pointSize: 14

            background: Rectangle {
                color: "#2bd91b"
                radius: 10
            }

            contentItem: Text {
                text: parent.text
                font.pixelSize: 22
                font.bold: true
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.family: "Tahoma"
            }

            onClicked: {
                console.log("Selected Shelf: " + shelfDropdown.currentText)
                console.log("Selected Location: " + locationDropdown.currentText)
            }
        }
        // Emergency Button
        Button {
            text: "Emergency Stop"
            width: 160
            height: 60
            font.bold: true
            font.pointSize: 11
            font.family: "Tahoma"

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 590
            anchors.horizontalCenterOffset: 518

            background: Rectangle {
                color: "red";
                radius: 10
            }

            contentItem: Text {
                text: "Emergency Stop"
                font.bold: true
                font.pointSize: 11
                font.family: "Tahoma"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            onClicked: console.log("Emergency Stop Triggered!")
        }
        // Back Button
        Button {
            text: "Back"
            width: 80
            height: 40
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 20
            font.bold: false
            font.pointSize: 10
            font.family: "Tahoma"
            display: AbstractButton.TextOnly

            background: Rectangle {
                color: "#D32F2F"
                radius: 10
            }

            contentItem: Text {
                text: parent.text
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                color: "white"
                anchors.centerIn: parent
            }

            onClicked: {
                automaticControlPage.visible = false
                selectionPage.visible = true
            }
        }
    }
    //--------------------------------------------------------------
    // Manual Control
    Item {
        id: manualControlPage
        visible: false
        anchors.fill: parent
        // Title
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
        // Logo Image
        Image {
            width: 161
            height: 133
            opacity: 1
            visible: true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 0
            anchors.topMargin: 10
            source: "qrc:/Images/ASU.png"
            clip: false
            fillMode: Image.PreserveAspectFit
            z:1
        }
        // Decorations
        Rectangle {
            x: 857
            width: 511
            height: 61
            opacity: 0.9
            color: "#525ed4"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: -2
            anchors.topMargin: 760
            z: -22
        }
        Rectangle {
            x: 1100
            y: 55
            width: 266
            height: 57
            opacity: 0.7
            color: "#525ed4"
            z: -22
        }

        Rectangle {
            x: 1100
            y: 450
            width: 266
            height: 57
            opacity: 0.7
            color: "#525ed4"
            z: -22
        }
        // Robot Movement
        Text {
            x: 1142
            width: 90
            height: 40
            color: "#f8f9fA"
            text: qsTr("Robot Control")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 120
            anchors.topMargin: 65
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            layer.enabled: false
            font.styleName: "Bold"
            font.bold: true
            font.family: "Tahoma"
        }

        Item {
            id: controlPanel
            width: parent.width
            height: parent.height

            property int buttonSize: 70
            property int stopSize: 70
            property int spacing: 15

            FocusScope {
                id: keyHandler
                focus: true

                onVisibleChanged: {
                    if (visible) keyHandler.forceActiveFocus();
                }

                Keys.onPressed: (event) => {
                                    event.accepted = true;

                                    switch (event.key) {
                                        case 16777235: // Numpad 8
                                        console.log("Move Forward");
                                        break;
                                        case 16777237: // Numpad 2
                                        console.log("Move Backward");
                                        break;
                                        case 16777234: // Numpad 4
                                        console.log("Move Left");
                                        break;
                                        case 16777236: // Numpad 6
                                        console.log("Move Right");
                                        break;
                                        case 16777233: // Numpad 7
                                        console.log("Move North-West");
                                        break;
                                        case 16777239: // Numpad 9
                                        console.log("Move North-East");
                                        break;
                                        case 16777232: // Numpad 1
                                        console.log("Move South-West");
                                        break;
                                        case 16777238: // Numpad 3
                                        console.log("Move South-East");
                                        break;
                                        case 16777227: // Numpad 5
                                        console.log("STOP");
                                        break;
                                        default:
                                        console.log("Unknown Key:", event.key);
                                    }
                                }
            }

            Column {
                id: movementGrid
                spacing: controlPanel.spacing

                // Row 1: NW, UP, NE
                Row {
                    spacing: controlPanel.spacing
                    Button {
                        text: "↖"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move North-West")
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "↑"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move Forward")
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "↗"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move North-East")
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }
                }

                // Row 2: LEFT, STOP, RIGHT
                Row {
                    spacing: controlPanel.spacing
                    Button {
                        text: "←"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move Left")
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "STOP"
                        width: controlPanel.stopSize
                        height: controlPanel.stopSize
                        font.pointSize: 16
                        onClicked: console.log("STOP")
                        background: Rectangle { color: "red"; radius: 10 }
                    }

                    Button {
                        text: "→"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move Right")
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }
                }

                // Row 3: SW, DOWN, SE
                Row {
                    spacing: controlPanel.spacing
                    Button {
                        text: "↙"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move South-West")
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "↓"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move Backward")
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "↘"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move South-East")
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }
                }
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 40
                anchors.topMargin: 150
            }
        }
        // Mechanism Control
        Text {
            x: 1188
            width: 90
            height: 40
            color: "#f8f9fA"
            text: qsTr("Mechanism Control")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 88
            anchors.topMargin: 460
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.styleName: "Bold"
            font.family: "Tahoma"
            font.bold: true
        }

        Item {
            id: mechanismControl
            anchors.fill: parent

            property int buttonWidth: 140
            property int buttonHeight: 50
            property int buttonRadius: 10

            // Ascend Button
            Button {
                id: ascend
                width: 100
                text: "Ascend"
                focusPolicy: Qt.NoFocus
                height: mechanismControl.buttonHeight
                font.pointSize: 16
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 160
                anchors.topMargin: 530
                font.bold: false
                font.family: "Tahoma"
                onClicked: console.log("Lift Ascend")

                background: Rectangle {
                    color: "#bbc4ca"
                    radius: mechanismControl.buttonRadius
                }
            }

            // Descend Button
            Button {
                id: descend
                width: 100
                text: "Descend"
                focusPolicy: Qt.NoFocus
                height: mechanismControl.buttonHeight
                font.pointSize: 16
                anchors.left: parent.right
                anchors.top: parent.top
                anchors.leftMargin: -130
                anchors.topMargin: 530
                font.family: "Tahoma"
                onClicked: console.log("Lift Descend")

                background: Rectangle {
                    color: "#bbc4ca"
                    radius: mechanismControl.buttonRadius
                }
            }
        }
        // Camera & Map Feed
        Rectangle {
            x: 20
            width: 500
            height: 405
            color: "#cccccc"
            anchors.right: parent.horizontalCenter
            anchors.top: parent.top
            anchors.rightMargin: 160
            anchors.topMargin: 209
            Text { anchors.centerIn: parent; text: "Camera Feed"; color: "black" }
        }

        Rectangle {
            width: 470
            height: 405
            color: "#cccccc"
            anchors.left: parent.horizontalCenter
            anchors.top: parent.top
            anchors.leftMargin: -145
            anchors.topMargin: 209
            Text { anchors.centerIn: parent; text: "Map"; color: "black" }
        }
        // Status & Battery Display
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            spacing: 10

            // Status Display
            Row {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Label {
                    text: "Status:"
                    font.pointSize: 16
                    font.bold: true
                    color: "black"
                }

                Label {
                    id: mstatusLabel
                    text: "Idle"
                    font.pointSize: 16
                    font.bold: true
                    color: "green"
                }
            }
            // Battery Level Display
            Column {
                spacing: 5
                anchors.horizontalCenter: parent.horizontalCenter

                Row {
                    spacing: 5
                    anchors.horizontalCenter: parent.horizontalCenter

                    Label {
                        text: "Battery:"
                        font.pointSize: 14
                        font.bold: true
                        color: "black"
                    }

                    Label {
                        id: mbatteryPercentage
                        text: "75%"
                        font.pointSize: 14
                        font.bold: true
                        color: "green"
                    }
                }

                Rectangle {
                    width: 200
                    height: 15
                    radius: 5
                    color: "#E0E0E0"

                    Rectangle {
                        id: mbatteryBar
                        width: parent.width * 0.75
                        height: parent.height
                        radius: 5
                        color: "green"
                    }
                }
                // Charge Button
                Button {
                    id: chargeButton
                    text: "Charge"
                    focusPolicy: Qt.NoFocus
                    width: 80
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.pointSize: 12
                    font.family: "Tahoma"

                    background: Rectangle {
                        color: "orange"
                        radius: 10
                    }

                    contentItem: Text {
                        text: parent.text
                        font.pixelSize: 16
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                        font.bold: true
                        color: "white"
                    }

                    onClicked: console.log("Charging started.")
                }
            }
        }
        // Back Button
        Button {
            text: "Back"
            focusPolicy: Qt.NoFocus
            width: 80
            height: 40
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            anchors.leftMargin: 20
            anchors.bottomMargin: 20
            font.bold: false
            font.pointSize: 10
            font.family: "Tahoma"
            display: AbstractButton.TextOnly

            background: Rectangle {
                color: "#D32F2F"
                radius: 10
            }

            contentItem: Text {
                text: parent.text
                font.pixelSize: 18
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
                font.bold: true
                color: "white"
                anchors.centerIn: parent
            }

            onClicked: {
                manualControlPage.visible = false
                selectionPage.visible = true
            }
        }
    }
}
