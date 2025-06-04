// Imports
import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Dialogs
import QtMultimedia

// Main
Window {
    id: main
    visible: true
    visibility: Window.FullScreen
    title: qsTr("ASLR Control Panel")
    color: "#ffffff"

    // Cursor
    MouseArea {
        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.ArrowCursor
    }

    // Splash Screen
    property bool splashDone: false

    //Overlay
    Rectangle {
        id: splashScreen
        anchors.fill: parent
        color: "#ffffff"
        visible: !main.splashDone
        z: 1000

        Image {
            id: splashImage
            source: "qrc:/Images/1.png"
            anchors.centerIn: parent
            width: 600
            height: 600
            fillMode: Image.PreserveAspectFit
            opacity: 1.0
        }

        Timer {
            interval: 2500
            running: true
            repeat: false
            onTriggered: fadeOutAnim.start()
        }

        SequentialAnimation {
            id: fadeOutAnim
            PropertyAnimation {
                target: splashScreen
                property: "opacity"
                from: 1
                to: 0
                duration: 1000
                easing.type: Easing.InOutQuad
            }
            ScriptAction {
                script: {
                    main.splashDone = true
                    splashScreen.visible = false
                }
            }
        }
    }

    // Connect Page
    Item {
        id: connectPage
        anchors.fill: parent
        visible: true

        // Time & Date Display
        Item {
            id: timeDateContainer
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.rightMargin: 20

            property string currentDate: Qt.formatDate(new Date(), "dddd, MMMM dd")
            property string currentTime: Qt.formatTime(new Date(), "hh:mm:ss ap")

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    timeDateContainer.currentTime = Qt.formatTime(new Date(), "hh:mm:ss ap")
                    timeDateContainer.currentDate = Qt.formatDate(new Date(), "dddd, MMMM dd")
                }
            }

            Rectangle {
                x: -195
                y: 0
                width: 250
                height: 70
                color: "#ffffff"

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: timeDateContainer.currentDate
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333333"
                    }

                    Text {
                        text: timeDateContainer.currentTime
                        font.pixelSize: 20
                        font.bold: true
                        color: "#222222"
                    }
                }
            }
        }

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
                x: 240
                y: 640
                width: 615
                height: 60
                text: "Connect Your ASLR"
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
                width: 315
                height: 315
                opacity: 1
                visible: true
                anchors.left: parent.left
                anchors.top: parent.top
                anchors.leftMargin: -35
                anchors.topMargin: -70
                source: "qrc:/Images/Logo.png"
                clip: false
                fillMode: Image.PreserveAspectFit
                z:1
            }
            // Decorations
            Rectangle {
                x: 856
                width: 2000
                height: 62
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
                focus: true
                anchors.horizontalCenter: parent.horizontalCenter
                anchors.verticalCenter: parent.verticalCenter
                font.pixelSize: 22

                background: Rectangle {
                    color: rosConnector.isConnected ? "#33dc23" : "#ff9a00"
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

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        rosConnector.connectToRos();
                    }
                }

                Keys.onReturnPressed: rosConnector.connectToRos()
                Keys.onEnterPressed: rosConnector.connectToRos()

                Connections {
                    target: rosConnector

                    function onConnectedToRos() {
                        connectPage.visible = false;
                        loginPage.visible = true;
                    }

                    function onConnectionFailed() {
                        connectionErrorDialog.open();
                    }
                }
            }

            // Connection Error Dialog
            Dialog {
                id: connectionErrorDialog
                modal: true
                width: 360
                height: 160

                x: (parent.width - width) / 2
                y: (parent.height - height) / 1.85

                background: Rectangle {
                    color: "#F8F9FA"
                    radius: 10
                }

                contentItem: Column {
                    spacing: 25
                    anchors.fill: parent
                    anchors.margins: 30

                    Label {
                        text: "Connection failed.\nPlease connect your ASLR to the network."
                        font.pixelSize: 16
                        font.bold: true
                        color: "#D32F2F"
                        horizontalAlignment: Text.AlignHCenter
                        wrapMode: Text.WordWrap
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    Row {
                        spacing: 20
                        anchors.horizontalCenter: parent.horizontalCenter

                        Button {
                            text: "OK"
                            width: 80
                            height: 40

                            background: Rectangle {
                                color: "#E0E0E0"
                                radius: 10
                            }

                            contentItem: Text {
                                text: "OK"
                                font.pixelSize: 16
                                font.bold: true
                                color: "black"
                                horizontalAlignment: Text.AlignHCenter
                                verticalAlignment: Text.AlignVCenter
                            }

                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: connectionErrorDialog.close()
                            }

                            Keys.onReturnPressed: connectionErrorDialog.close()
                        }
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

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: exitDialog.open()
                }
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
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
                                onClicked: exitDialog.close()
                            }
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
                            MouseArea {
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
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
    }
    //--------------------------------------------------------------
    // Login Page
    Item {
        id: loginPage
        anchors.fill: parent
        visible: false

        // Time & Date Display
        Item {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.rightMargin: 20

            property string currentDate: Qt.formatDate(new Date(), "dddd, MMMM dd")
            property string currentTime: Qt.formatTime(new Date(), "hh:mm:ss ap")

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    timeDateContainer.currentTime = Qt.formatTime(new Date(), "hh:mm:ss ap")
                    timeDateContainer.currentDate = Qt.formatDate(new Date(), "dddd, MMMM dd")
                }
            }

            Rectangle {
                x: -195
                y: 0
                width: 250
                height: 70
                color: "#ffffff"

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: timeDateContainer.currentDate
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333333"
                    }

                    Text {
                        text: timeDateContainer.currentTime
                        font.pixelSize: 20
                        font.bold: true
                        color: "#222222"
                    }
                }
            }
        }

        // Title
        Text {
            x: 240
            y: 640
            width: 615
            height: 60
            text: "Enter Credentials"
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
            width: 315
            height: 315
            opacity: 1
            visible: true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: -35
            anchors.topMargin: -70
            source: "qrc:/Images/Logo.png"
            clip: false
            fillMode: Image.PreserveAspectFit
            z:1
        }
        // Decorations
        Rectangle {
            x: 856
            width: 2000
            height: 62
            opacity: 0.9
            color: "#3E424B"
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
                Keys.onReturnPressed: {
                    if (emailField.text === "" || passwordField.text === "") {
                        loginerrorDialog.open();
                        okButton.focus = true;
                    } else {
                        authManager.loginUser(emailField.text, passwordField.text);
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
                }
                Keys.onReturnPressed: {
                    if (emailField.text === "" || passwordField.text === "") {
                        loginerrorDialog.open();
                        okButton.focus = true;
                    } else {
                        authManager.loginUser(emailField.text, passwordField.text);
                    }
                }
            }

            // Login Button
            Button {
                id: loginButton
                text: "SIGN IN"
                width: 155
                height: 45
                anchors.horizontalCenter: parent.horizontalCenter

                background: Rectangle {
                    color: "#2196F3"
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

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        if (emailField.text === "" || passwordField.text === "") {
                            loginerrorDialog.open();
                            okButton.focus = true;
                        } else {
                            authManager.loginUser(emailField.text, passwordField.text);
                        }
                    }
                }
            }
        }

        // Success and Error Handling
        Connections {
            target: authManager

            onLoginSuccess: {
                loginPage.visible = false;
                selectionPage.visible = true;
            }

            onLoginFailed: (errorMessage) => {
                               loginerrorDialog.open();
                               okButton.focus = true;
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
                        id: okButton
                        text: "OK"
                        width: 80
                        height: 40
                        focus: true
                        background: Rectangle {
                            color: "#E0E0E0"
                            radius: 10
                        }
                        contentItem: Text {
                            text: "OK"
                            font.pixelSize: 16
                            font.bold: true
                            color: "black"
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                        }
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                loginerrorDialog.close();
                                emailField.focus = true;
                            }
                        }
                        Keys.onReturnPressed: {
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    loginPage.visible = false
                    connectPage.visible = true
                }
            }
        }
    }
    //--------------------------------------------------------------
    // Selection Page
    Item {
        id: selectionPage
        anchors.fill: parent
        visible: false

        // Time & Date Display
        Item {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.rightMargin: 20

            property string currentDate: Qt.formatDate(new Date(), "dddd, MMMM dd")
            property string currentTime: Qt.formatTime(new Date(), "hh:mm:ss ap")

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    timeDateContainer.currentTime = Qt.formatTime(new Date(), "hh:mm:ss ap")
                    timeDateContainer.currentDate = Qt.formatDate(new Date(), "dddd, MMMM dd")
                }
            }

            Rectangle {
                x: -195
                y: 0
                width: 250
                height: 70
                color: "#ffffff"

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: timeDateContainer.currentDate
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333333"
                    }

                    Text {
                        text: timeDateContainer.currentTime
                        font.pixelSize: 20
                        font.bold: true
                        color: "#222222"
                    }
                }
            }
        }

        // Title
        Text {
            x: 240
            y: 640
            width: 615
            height: 60
            text: "Select Control Type"
            elide: Text.ElideNone
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            anchors.rightMargin: -54
            anchors.bottomMargin: 0
            font.pixelSize: 40
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
            width: 315
            height: 315
            opacity: 1
            visible: true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: -35
            anchors.topMargin: -70
            source: "qrc:/Images/Logo.png"
            clip: false
            fillMode: Image.PreserveAspectFit
            z:1
        }
        // Decorations
        Rectangle {
            x: 856
            width: 2000
            height: 62
            opacity: 0.9
            color: "#2196F3"
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

                Rectangle {
                    id: controlToggle
                    width: 320
                    height: 60
                    radius: 30
                    color: "#DBE2E9"

                    property bool isAutomatic: true

                    RowLayout {
                        anchors.fill: parent
                        spacing: 0

                        Rectangle {
                            Layout.fillWidth: true
                            Layout.fillHeight: true
                            radius: controlToggle.radius
                            color: autonomousMouseArea.containsMouse ? "#2196F3"
                                                                     : "#DBE2E9"


                            Text {
                                text: "AUTONOMOUS"
                                font.pixelSize: 18
                                font.bold: true
                                color: autonomousMouseArea.containsMouse ? "white" : "black"
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                id: autonomousMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
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
                            color: manualMouseArea.containsMouse ? "#2196F3"
                                                                 : "#DBE2E9"

                            Text {
                                text: "MANUAL"
                                font.pixelSize: 18
                                font.bold: true
                                color: manualMouseArea.containsMouse ? "white" : "black"
                                anchors.centerIn: parent
                            }

                            MouseArea {
                                id: manualMouseArea
                                anchors.fill: parent
                                hoverEnabled: true
                                cursorShape: Qt.PointingHandCursor
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    selectionPage.visible = false
                    loginPage.visible = true
                    emailField.text = ""
                    passwordField.text = ""
                    console.log("Signed out.")
                }
            }
        }
    }
    //--------------------------------------------------------------
    // Automatic Control
    Item {
        id: automaticControlPage
        anchors.fill: parent
        visible: false

        // Time & Date Display
        Item {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.rightMargin: 20

            property string currentDate: Qt.formatDate(new Date(), "dddd, MMMM dd")
            property string currentTime: Qt.formatTime(new Date(), "hh:mm:ss ap")

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    timeDateContainer.currentTime = Qt.formatTime(new Date(), "hh:mm:ss ap")
                    timeDateContainer.currentDate = Qt.formatDate(new Date(), "dddd, MMMM dd")
                }
            }

            Rectangle {
                x: -195
                y: 0
                width: 250
                height: 70
                color: "#ffffff"

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: timeDateContainer.currentDate
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333333"
                    }

                    Text {
                        text: timeDateContainer.currentTime
                        font.pixelSize: 20
                        font.bold: true
                        color: "#222222"
                    }
                }
            }
        }

        // Title
        Text {
            x: 240
            y: 640
            width: 615
            height: 60
            text: "Autonomous Mode"
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
            width: 315
            height: 315
            opacity: 1
            visible: true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: -35
            anchors.topMargin: -70
            source: "qrc:/Images/Logo.png"
            clip: false
            fillMode: Image.PreserveAspectFit
            z:1
        }
        // Decorations
        Rectangle {
            x: 856
            width: 2000
            height: 60
            opacity: 0.9
            color: "#18C519"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: -2
            anchors.topMargin: 760
            z: -22
        }
        Rectangle {
            x: 1100
            y: 100
            width: 266
            height: 55
            opacity: 0.7
            color: "#525ed4"
            z: -22
        }
        Text {
            x: 1142
            width: 90
            height: 40
            color: "#f8f9fA"
            text: qsTr("Pick & Drop")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 120
            anchors.topMargin: 108
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            layer.enabled: false
            font.styleName: "Bold"
            font.bold: true
            font.family: "Tahoma"
        }
        Rectangle {
            x: 0
            y: 160
            width: 266
            height: 55
            opacity: 0.7
            color: "#525ed4"
            z: 22
        }
        Text {
            x: 2
            z: 23
            width: 90
            height: 40
            color: "#f8f9fA"
            text: qsTr("Warehouse Map")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 108
            anchors.topMargin: 167
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            layer.enabled: false
            font.styleName: "Bold"
            font.bold: true
            font.family: "Tahoma"
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
                    id: statusLabel
                    text: "Idle"
                    font.pointSize: 16
                    font.bold: true
                    color: "orange"
                }

                Connections {
                    target: rosConnector

                    onMessageReceived: function(message) {
                        try {
                            let data = JSON.parse(message);
                            console.log("Received message for status:", data);

                            if (data.topic === "/cmd_vel" || data.topic === "/hoverboard_velocity_controller/cmd_vel") {
                                let twist = data.msg;
                                let moving = !(
                                    twist.linear.x === 0 &&
                                    twist.linear.y === 0 &&
                                    twist.linear.z === 0 &&
                                    twist.angular.x === 0 &&
                                    twist.angular.y === 0 &&
                                    twist.angular.z === 0
                                );
                                updateStatus(moving);
                            }
                        } catch (e) {
                            console.error("Error parsing message:", e);
                        }
                    }
                }

                function updateStatus(isMoving) {
                    console.log("Status update:", isMoving ? "Busy" : "Idle");
                    statusLabel.text = isMoving ? "Busy" : "Idle";
                    statusLabel.color = isMoving ? "red" : "orange";
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
                        id: batteryPercentageLabel
                        text: " 0%"
                        font.pointSize: 14
                        font.bold: true
                    }

                    Timer {
                        id: batterySubscribeTimer
                        interval: 1000
                        running: true
                        repeat: true
                    }

                    Connections {
                        target: rosConnector

                        onMessageReceived: function(message) {
                            try {
                                let data = JSON.parse(message);
                                console.log("Received battery message:", data);
                                if (data.topic === "/hoverboard/battery_voltage") {
                                    let voltage = data.msg.data;

                                    let percentage = ((voltage - 33) / (42 - 33)) * 100;
                                    percentage = Math.min(100, Math.max(0, percentage));

                                    batteryPercentageLabel.text = Math.round(percentage) + "%";
                                    batteryBar.width = 200 * (percentage / 100);

                                    if (percentage > 60) {
                                        batteryPercentageLabel.color = "green";
                                        batteryBar.color = "green";
                                    } else if (percentage > 30) {
                                        batteryPercentageLabel.color = "orange";
                                        batteryBar.color = "orange";
                                    } else {
                                        batteryPercentageLabel.color = "red";
                                        batteryBar.color = "red";
                                    }
                                }
                            } catch (e) {
                                console.log("Battery message parse error:", e);
                            }
                        }
                    }
                }

                Rectangle {
                    width: 200
                    height: 15
                    radius: 5
                    color: "#E0E0E0"

                    Rectangle {
                        id: batteryBar
                        height: parent.height
                        radius: 5
                    }
                }
            }
        }

        // Notification
        Text {
            id: statusMessage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 120
            font.pointSize: 14
            font.bold: true
            font.family: "Tahoma"
            color: "black"
            visible: false
            text: " "
        }

        Timer {
            id: statusTimer
            interval: 5000
            running: false
            repeat: false
            onTriggered: statusMessage.visible = false
        }

        // Pick & Drop
        Column {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 190
            anchors.rightMargin: 80
            spacing: 80

            property var goalCoordinates: {
                "Shelf A": { x: 8.47661 , y: 0.073312 },
                "Shelf B": { x: 8.553205421856358, y: 0.073312 -4.552061918829988 },
                "Shelf C": { x: 2.51197 , y: -4.50967 },
                "Shelf D": { x: 2.51197 , y:  -1.16554 },
                "Location 1": { x: 10.8946 , y: -2.29781 },
                "Location 2": { x: 13.2928 , y: -5.59084 },
                "Location 3": { x: 10.8946 , y: -6.70115 },
            }

            // Pick
            Column {
                spacing: 10

                Label {
                    text: "SHELVES"
                    font.pointSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    font.italic: true
                    font.underline: false
                }

                ComboBox {
                    id: shelfDropdown
                    width: 180
                    height: 40
                    model: ["", "Shelf A", "Shelf B", "Shelf C" , "Shelf D"]
                    currentIndex: -1

                    background: Rectangle {
                        color: "#DBE2E9"
                        radius: 8
                    }

                    contentItem: Text {
                        text: shelfDropdown.currentText || "Select a Shelf"
                        color: "black"
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    indicator: Rectangle {
                        width: 5
                        height: 5
                        radius: 5
                        color: "black"
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 10
                    }
                }
            }

            // Drop
            Column {
                spacing: 10

                Label {
                    text: "LOCATIONS"
                    font.pointSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    font.underline: false
                    font.italic: true
                }

                ComboBox {
                    id: locationDropdown
                    width: 180
                    height: 40
                    model: ["", "Location 1", "Location 2", "Location 3"]

                    background: Rectangle {
                        color: "#DBE2E9"
                        radius: 8
                    }

                    contentItem: Text {
                        text: locationDropdown.currentText || "Select a Location"
                        color: "black"
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    indicator: Rectangle {
                        width: 5
                        height: 5
                        radius: 5
                        color: "black"
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 10
                    }
                }
            }
        }

        // Send Start Goal
        Button {
            text: "PICK"
            width: 180
            height: 40
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 280
            anchors.rightMargin: 80
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                property var goalCoordinates: {
                    "Shelf A": { x: 8.47661 , y: 0.073312 },
                    "Shelf B": { x: 8.553205421856358, y: 0.073312 -4.552061918829988 },
                    "Shelf C": { x: 2.51197 , y: -4.50967 },
                    "Shelf D": { x: 2.51197 , y:  -1.16554 },
                    "Location 1": { x: 10.8946 , y: -2.29781 },
                    "Location 2": { x: 13.2928 , y: -5.59084 },
                    "Location 3": { x: 10.8946 , y: -6.70115 },
                }
                onClicked: {
                    console.log("Selected Shelf: " + shelfDropdown.currentText);
                    console.log("Selected Location: " + locationDropdown.currentText);

                    var shelf = shelfDropdown.currentText;
                    var goal = goalCoordinates[shelf];

                    if (goal) {
                        console.log("Sending goal: x=" + goal.x + " y=" + goal.y);
                        rosConnector.sendGoal(goal.x, goal.y);
                        statusMessage.text = "ASLR is going to " + shelf + "...";
                        statusMessage.color = "green";
                        statusMessage.visible = true;
                        statusTimer.start();
                    } else {
                        console.warn("Invalid shelf selected!");
                        statusMessage.text = "Please select a valid shelf.";
                        statusMessage.color = "red";
                        statusMessage.visible = true;
                        statusTimer.start();
                    }
                }
            }
        }

        // Send End Goal
        Button {
            text: "DROP"
            width: 180
            height: 40
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 440
            anchors.rightMargin: 80
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                property var goalCoordinates: {
                    "Shelf A": { x: 8.47661 , y: 0.073312 },
                    "Shelf B": { x: 8.553205421856358, y: 0.073312 -4.552061918829988 },
                    "Shelf C": { x: 2.51197 , y: -4.50967 },
                    "Shelf D": { x: 2.51197 , y:  -1.16554 },
                    "Location 1": { x: 10.8946 , y: -2.29781 },
                    "Location 2": { x: 13.2928 , y: -5.59084 },
                    "Location 3": { x: 10.8946 , y: -6.70115 },
                }
                onClicked: {
                    console.log("Selected Shelf: " + shelfDropdown.currentText);
                    console.log("Selected Location: " + locationDropdown.currentText);

                    var location = locationDropdown.currentText;
                    var goal = goalCoordinates[location];

                    if (goal) {
                        console.log("Sending goal: x=" + goal.x + " y=" + goal.y);
                        rosConnector.sendGoal(goal.x, goal.y);
                        statusMessage.text = "Dropping the shelf at " + location + "...";
                        statusMessage.color = "green";
                        statusMessage.visible = true;
                        statusTimer.start();
                    } else {
                        console.warn("Invalid location selected!");
                        statusMessage.text = "Please select a valid location.";
                        statusMessage.color = "red";
                        statusMessage.visible = true;
                        statusTimer.start();
                    }
                }
            }
        }

        // QR Scan
        Item {
            id: qrScanner
            width: parent.width
            height: parent.height
            z: 100

            property bool cameraVisible: false
            property real cameraWidth: cameraVisible ? 600 : 0
            property real cameraHeight: cameraVisible ? 500 : 0
            property var scannedCoordinates: []

            Camera {
                id: camera
                active: qrScanner.cameraVisible
            }

            CaptureSession {
                id: captureSession
                camera: camera
                videoOutput: viewfinder
            }

            VideoOutput {
                id: viewfinder
                anchors.centerIn: parent
                width: qrScanner.cameraWidth
                height: qrScanner.cameraHeight
                visible: qrScanner.cameraVisible
                fillMode: VideoOutput.PreserveAspectFit
            }

            Timer {
                interval: 1000
                running: qrScanner.cameraVisible
                repeat: true
                onTriggered: {
                    if (qrScanner.cameraVisible)
                        qrDecoder.decodeImage(viewfinder.videoFrame);
                }
            }

            Button {
                id: toggleButton
                width: 160
                height: 50
                x: parent.width - width - 90
                y: 520
                text: qrScanner.cameraVisible ? "CLOSE QR CAMERA" : "OPEN QR CAMERA"

                font.pointSize: 12
                font.bold: true

                background: Rectangle {
                    color: qrScanner.cameraVisible ? "#ff9a00" : "#ff9a00"
                    radius: 12
                }

                contentItem: Text {
                    text: toggleButton.text
                    color: "white"
                    font: toggleButton.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        qrScanner.cameraVisible = !qrScanner.cameraVisible;
                    }
                }
            }
        }

        // Emergency Button
        Button {
            text: "Emergency Stop"
            width: 160
            height: 60
            font.bold: true
            font.pointSize: 13
            font.family: "Tahoma"

            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 90
            anchors.topMargin: 600

            background: Rectangle {
                color: "red";
                radius: 10
            }

            contentItem: Text {
                text: "Emergency Stop"
                font.bold: true
                font.pointSize: 12
                font.family: "Tahoma"
                color: "white"
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignVCenter
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {console.log("Emergency Stop Triggered!");
                    rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                    rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                    statusMessage.text = "ASLR Stopped!";
                    statusMessage.color = "red";
                    statusMessage.visible = true;
                    statusTimer.start();
                }
            }
        }

        // Digital Twin
        Row {
            id: cameraMapRow
            property real mapScalex: 59
            property real mapScaley: 48
            property real mapWidth: digitalTwinMap.width
            property real mapHeight: digitalTwinMap.height

            // Initial pixel anchor
            property real initialPixelX: 50
            property real initialPixelY: 90

            // Dynamic robot pose in pixels
            property real robotX: initialPixelX
            property real robotY: initialPixelY
            property real robotRotation: 0

            // AMCL origin to align ROS coordinates with pixel space
            property real originX: undefined
            property real originY: undefined

            // Convert from ROS meters to pixels
            function metersToPixelsX(x) {
                return (x - originX) * mapScalex + initialPixelX;
            }

            function metersToPixelsY(y) {
                return initialPixelY - (y - originY) * mapScaley;
            }

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 230
            anchors.rightMargin: 100
            spacing: 30

            Rectangle {
                id: digitalTwinMap
                width: 900
                height: 450
                color: "#f0f0f0"

                Image {
                    id: mapImage
                    anchors.fill: parent
                    source: "qrc:/Images/map_with_shelves.png"
                }

                // Global path canvas
                Canvas {
                    id: pathCanvas
                    anchors.fill: parent
                    property var globalPath: []

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.clearRect(0, 0, width, height);
                        ctx.lineWidth = 2;
                        ctx.strokeStyle = "blue";

                        if (globalPath.length > 1) {
                            ctx.beginPath();
                            ctx.moveTo(globalPath[0].x, globalPath[0].y);
                            for (var i = 1; i < globalPath.length; i++) {
                                ctx.lineTo(globalPath[i].x, globalPath[i].y);
                            }
                            ctx.stroke();
                        }
                    }
                }

                // Robot Icon
                Image {
                    id: robotIcon
                    source: "qrc:/Images/LiftRobot.png"
                    width: 40
                    height: 40
                    x: cameraMapRow.robotX - width / 2
                    y: cameraMapRow.robotY - height / 2
                    rotation: cameraMapRow.robotRotation
                    transformOrigin: Item.Center
                    smooth: true
                    antialiasing: true
                }

                // Goal marker
                Image {
                    id: goalMarker
                    source: "qrc:/Images/flag.png"
                    width: 40
                    height: 40
                    visible: false
                    z: 10
                    smooth: true
                    antialiasing: true
                }
            }

            NumberAnimation on robotX { duration: 5 }
            NumberAnimation on robotY { duration: 5 }

            Connections {
                target: rosConnector

                function onPoseReceived(json) {
                    var pose = JSON.parse(json);
                    var x = pose.position.x;
                    var y = pose.position.y;
                    var q = pose.orientation;

                    if (cameraMapRow.originX === undefined || cameraMapRow.originY === undefined) {
                        cameraMapRow.originX = x;
                        cameraMapRow.originY = y;
                        console.log("Origin set to:", x, y);
                    }

                    cameraMapRow.robotX = cameraMapRow.metersToPixelsX(x);
                    cameraMapRow.robotY = cameraMapRow.metersToPixelsY(y);
                    cameraMapRow.robotRotation = Math.atan2(2.0 * (q.w * q.z), 1.0 - 2.0 * (q.z * q.z)) * 180 / Math.PI;
                }

                function onGlobalPathReceived(json) {
                    var arr = JSON.parse(json);

                    if (cameraMapRow.originX === undefined || cameraMapRow.originY === undefined) {
                        console.log("Skipping path drawing until origin is known.");
                        return;
                    }

                    pathCanvas.globalPath = arr.map(p => ({
                                                              x: cameraMapRow.metersToPixelsX(p.pose.position.x),
                                                              y: cameraMapRow.metersToPixelsY(p.pose.position.y)
                                                          }));
                    pathCanvas.requestPaint();
                }

                function onGoalReceived(json) {
                    var goal = JSON.parse(json);
                    var x = goal.position.x;
                    var y = goal.position.y;

                    if (cameraMapRow.originX === undefined || cameraMapRow.originY === undefined)
                        return;

                    var pixelX = cameraMapRow.metersToPixelsX(x);
                    var pixelY = cameraMapRow.metersToPixelsY(y);

                    goalMarker.visible = true;
                    goalMarker.x = pixelX - goalMarker.width / 2;
                    goalMarker.y = pixelY - goalMarker.height / 2;

                    console.log("Goal marker placed at:", pixelX, pixelY);
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

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    automaticControlPage.visible = false
                    selectionPage.visible = true
                }
            }
        }
    }
    //--------------------------------------------------------------
    // Manual Control
    Item {
        id: manualControlPage
        visible: false
        anchors.fill: parent

        // Time & Date Display
        Item {
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 20
            anchors.rightMargin: 20

            property string currentDate: Qt.formatDate(new Date(), "dddd, MMMM dd")
            property string currentTime: Qt.formatTime(new Date(), "hh:mm:ss ap")

            Timer {
                interval: 1000
                running: true
                repeat: true
                onTriggered: {
                    timeDateContainer.currentTime = Qt.formatTime(new Date(), "hh:mm:ss ap")
                    timeDateContainer.currentDate = Qt.formatDate(new Date(), "dddd, MMMM dd")
                }
            }

            Rectangle {
                x: -195
                y: 0
                width: 250
                height: 70
                color: "#ffffff"

                Column {
                    anchors.centerIn: parent
                    spacing: 2

                    Text {
                        text: timeDateContainer.currentDate
                        font.pixelSize: 16
                        font.bold: true
                        color: "#333333"
                    }

                    Text {
                        text: timeDateContainer.currentTime
                        font.pixelSize: 20
                        font.bold: true
                        color: "#222222"
                    }
                }
            }
        }

        // Title
        Text {
            x: 240
            y: 640
            width: 615
            height: 60
            text: "Manual Drive Mode"
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
            width: 315
            height: 315
            opacity: 1
            visible: true
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: -35
            anchors.topMargin: -70
            source: "qrc:/Images/Logo.png"
            clip: false
            fillMode: Image.PreserveAspectFit
            z:1
        }
        // Decorations
        Rectangle {
            x: 856
            width: 2000
            height: 60
            opacity: 0.9
            color: "#18C519"
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: -2
            anchors.topMargin: 760
            z: -22
        }
        Rectangle {
            x: 1100
            y: 100
            width: 266
            height: 56
            opacity: 0.7
            color: "#525ed4"
            z: -22
        }
        Text {
            x: 1142
            width: 90
            height: 40
            color: "#f8f9fA"
            text: qsTr("Robot Control")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 120
            anchors.topMargin: 108
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            layer.enabled: false
            font.styleName: "Bold"
            font.bold: true
            font.family: "Tahoma"
        }
        Rectangle {
            x: 1100
            y: 470
            width: 266
            height: 56
            opacity: 0.7
            color: "#525ed4"
            z: -22
        }
        Text {
            x: 1188
            width: 90
            height: 40
            color: "#f8f9fA"
            text: qsTr("Mechanism Control")
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 88
            anchors.topMargin: 478
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            font.styleName: "Bold"
            font.family: "Tahoma"
            font.bold: true
        }
        Rectangle {
            x: 0
            y: 160
            width: 266
            height: 55
            opacity: 0.7
            color: "#525ed4"
            z: 22
        }
        Text {
            x: 2
            z: 23
            width: 90
            height: 40
            color: "#f8f9fA"
            text: qsTr("Warehouse Map")
            anchors.left: parent.left
            anchors.top: parent.top
            anchors.leftMargin: 108
            anchors.topMargin: 167
            font.pixelSize: 24
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            layer.enabled: false
            font.styleName: "Bold"
            font.bold: true
            font.family: "Tahoma"
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
                    color: "orange"
                }

                Connections {
                    target: rosConnector

                    function updateStatus(isMoving) {
                        console.log("Status update:", isMoving ? "Busy" : "Idle");
                        mstatusLabel.text = isMoving ? "Busy" : "Idle";
                        mstatusLabel.color = isMoving ? "red" : "orange";
                    }

                    function handleVelocity(message) {
                        try {
                            let twist = JSON.parse(message);
                            console.log("Received twist:", twist);

                            let moving = !(
                                twist.linear.x === 0 &&
                                twist.linear.y === 0 &&
                                twist.linear.z === 0 &&
                                twist.angular.x === 0 &&
                                twist.angular.y === 0 &&
                                twist.angular.z === 0
                            );
                            updateStatus(moving);
                        } catch (e) {
                            console.error("Error parsing twist:", e);
                        }
                    }

                    onCmdVelReceived: function(message) {
                        handleVelocity(message);
                    }

                    onHoverboardCmdVelReceived: function(message) {
                        handleVelocity(message);
                    }
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
                        text: " 0%"
                        font.pointSize: 14
                        font.bold: true
                    }

                    Timer {
                        id: mbatterySubscribeTimer
                        interval: 1000
                        running: true
                        repeat: true
                    }
                    Connections {
                        target: rosConnector

                        onMessageReceived: function(message) {
                            try {
                                let data = JSON.parse(message);
                                console.log("Received battery message:", data);
                                if (data.topic === "/hoverboard/battery_voltage") {
                                    let voltage = data.msg.data

                                    let percentage = ((voltage - 33) / (42 - 33)) * 100
                                    percentage = Math.min(100, Math.max(0, percentage))

                                    mbatteryPercentage.text = Math.round(percentage) + "%"
                                    mbatteryBar.width = 200 * (percentage / 100)

                                    if (percentage > 60) {
                                        mbatteryPercentage.color = "green"
                                        mbatteryBar.color = "green"
                                    } else if (percentage > 30) {
                                        mbatteryPercentage.color = "orange"
                                        mbatteryBar.color = "orange"
                                    } else {
                                        mbatteryPercentage.color = "red"
                                        mbatteryBar.color = "red"
                                    }
                                }
                            } catch (e) {
                                console.log("Battery message parse error:", e)
                            }
                        }
                    }
                }

                Rectangle {
                    width: 200
                    height: 15
                    radius: 5
                    color: "#E0E0E0"

                    Rectangle {
                        id: mbatteryBar
                        height: parent.height
                        radius: 5
                    }
                }

                // Charge Button
                Button {
                    id: chargeButton
                    text: "CHARGE"
                    focusPolicy: Qt.NoFocus
                    width: 90
                    height: 40
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.bold: true
                    font.pointSize: 14
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

                    MouseArea {
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            console.log("Heading to charging station.")
                            rosConnector.goToChargingStation()
                            mstatusMessage.text = "Heading to Charging Station."
                            mstatusMessage.color = "orange"
                            mstatusMessage.visible = true
                            mstatusTimer.start();
                        }
                    }
                }
            }
        }

        // Notification
        Text {
            id: mstatusMessage
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 160
            font.pointSize: 14
            font.bold: true
            font.family: "Tahoma"
            color: "black"
            visible: false
            text: " "
        }

        Timer {
            id: mstatusTimer
            interval: 3000
            running: false
            repeat: false
            onTriggered: mstatusMessage.visible = false
        }

        // Robot Movement
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
                    if (manualControlPage.visible === true) keyHandler.forceActiveFocus();
                }

                Keys.onPressed: (event) => {
                                    event.accepted = true;

                                    switch (event.key) {
                                        case 16777235: // Numpad 8
                                        console.log("Move Forward");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        mstatusMessage.text = "Moving Forward...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case 16777237: // Numpad 2
                                        console.log("Move Backward");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        mstatusMessage.text = "Moving Backward...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case 16777234: // Numpad 4
                                        console.log("Move Left");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        mstatusMessage.text = "Moving Left...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case 16777236: // Numpad 6
                                        console.log("Move Right");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        mstatusMessage.text = "Moving Right...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case 16777233: // Numpad 1
                                        console.log("Move South-West");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        mstatusMessage.text = "Moving SW...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case 16777239: // Numpad 3
                                        console.log("Move South-East");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        mstatusMessage.text = "Moving SE...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case 16777232: // Numpad 7
                                        console.log("Move North-West");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        mstatusMessage.text = "Moving NW...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case 16777238: // Numpad 9
                                        console.log("Move North-East");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        mstatusMessage.text = "Moving NE...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case 16777227: // Numpad 5
                                        console.log("STOP");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        mstatusMessage.text = "ASLR Stopped.";
                                        mstatusMessage.color = "red";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case Qt.Key_A: // A key for Ascend
                                        console.log("Lift Ascend");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/linear_actuator_cmd","msg":{"data":"0"}}');
                                        mstatusMessage.text = "Ascedning Mechanism...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case Qt.Key_D: // D key for Descend
                                        console.log("Lift Descend");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/linear_actuator_cmd","msg":{"data":"1"}}');
                                        mstatusMessage.text = "Descending Mechanism...";
                                        mstatusMessage.color = "green";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
                                        break;

                                        case Qt.Key_S: // S key for Lift Stop
                                        console.log("Lift Stop");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/linear_actuator_cmd","msg":{"data":"x"}}');
                                        mstatusMessage.text = "Mechanism Stopped.";
                                        mstatusMessage.color = "red";
                                        mstatusMessage.visible = true;
                                        mstatusTimer.start();
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
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("Move North-West") &
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                mstatusMessage.text = "Moving NW...";
                                mstatusMessage.color = "green";
                                mstatusMessage.visible = true;
                                mstatusTimer.start();
                            }
                        }
                        background: Rectangle { color: "#DBE2E9"; radius: 10 }
                    }

                    Button {
                        text: "↑"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("Move Forward");
                                rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                mstatusMessage.text = "Moving Forward...";
                                mstatusMessage.color = "green";
                                mstatusMessage.visible = true;
                                mstatusTimer.start();
                            }
                        }
                        background: Rectangle { color: "#DBE2E9"; radius: 10 }
                    }

                    Button {
                        text: "↗"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("Move North-East");
                                rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                mstatusMessage.text = "Moving NE...";
                                mstatusMessage.color = "green";
                                mstatusMessage.visible = true;
                                mstatusTimer.start();
                            }
                        }
                        background: Rectangle { color: "#DBE2E9"; radius: 10 }
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
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("Move Left");
                                rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                mstatusMessage.text = "Moving Left...";
                                mstatusMessage.color = "green";
                                mstatusMessage.visible = true;
                                mstatusTimer.start();
                            }
                        }
                        background: Rectangle { color: "#DBE2E9"; radius: 10 }
                    }

                    Button {
                        text: "STOP"
                        width: controlPanel.stopSize
                        height: controlPanel.stopSize
                        font.pointSize: 16
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("STOP");
                                rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                mstatusMessage.text = "ASLR Stopped.";
                                mstatusMessage.color = "red";
                                mstatusMessage.visible = true;
                                mstatusTimer.start();
                            }
                        }
                        background: Rectangle {
                            color: "red"
                            radius: 10
                        }

                        contentItem: Text {
                            text: "STOP"
                            font.pointSize: 16
                            color: "white"
                            font.bold: true
                            horizontalAlignment: Text.AlignHCenter
                            verticalAlignment: Text.AlignVCenter
                            anchors.fill: parent
                        }
                    }

                    Button {
                        text: "→"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("Move Right");
                                rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                mstatusMessage.text = "Moving Right...";
                                mstatusMessage.color = "green";
                                mstatusMessage.visible = true;
                                mstatusTimer.start();
                            }
                        }
                        background: Rectangle { color: "#DBE2E9"; radius: 10 }
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
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("Move South-West");
                                rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                mstatusMessage.text = "Moving SW...";
                                mstatusMessage.color = "green";
                                mstatusMessage.visible = true;
                                mstatusTimer.start();
                            }
                        }
                        background: Rectangle { color: "#DBE2E9"; radius: 10 }
                    }

                    Button {
                        text: "↓"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("Move Backward");
                                rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                mstatusMessage.text = "Moving Backward...";
                                mstatusMessage.color = "green";
                                mstatusMessage.visible = true;
                                mstatusTimer.start();
                            }
                        }
                        background: Rectangle { color: "#DBE2E9"; radius: 10 }
                    }

                    Button {
                        text: "↘"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            cursorShape: Qt.PointingHandCursor
                            onClicked: {
                                console.log("Move South-East");
                                rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                mstatusMessage.text = "Moving SE...";
                                mstatusMessage.color = "green";
                                mstatusMessage.visible = true;
                                mstatusTimer.start();
                            }
                        }
                        background: Rectangle { color: "#DBE2E9"; radius: 10 }
                    }
                }
                anchors.right: parent.right
                anchors.top: parent.top
                anchors.rightMargin: 30
                anchors.topMargin: 190
            }
        }

        // Mechanism Control
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
                anchors.topMargin: 550
                font.bold: false
                font.family: "Tahoma"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log("Lift Ascend");
                        rosConnector.sendMessage(JSON.stringify({
                                                                    op: "publish",
                                                                    topic: "/linear_actuator_cmd",
                                                                    msg: {
                                                                        data: "0"
                                                                    }
                                                                }));
                        mstatusMessage.text = "Ascending Mechanism...";
                        mstatusMessage.color = "green";
                        mstatusMessage.visible = true;
                        mstatusTimer.start();
                    }
                }
                background: Rectangle {
                    color: "#DBE2E9"
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
                anchors.topMargin: 550
                font.family: "Tahoma"
                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log("Lift Descend");
                        rosConnector.sendMessage(JSON.stringify({
                                                                    op: "publish",
                                                                    topic: "/linear_actuator_cmd",
                                                                    msg: {
                                                                        data: "1"
                                                                    }
                                                                }));
                        mstatusMessage.text = "Descending Mechanism...";
                        mstatusMessage.color = "green";
                        mstatusMessage.visible = true;
                        mstatusTimer.start();
                    }
                }
                background: Rectangle {
                    color: "#DBE2E9"
                    radius: mechanismControl.buttonRadius
                }
            }
            Button {
                id: stoplift
                width: 100
                text: "STOP"
                focusPolicy: Qt.NoFocus
                height: mechanismControl.buttonHeight
                font.pointSize: 16
                anchors.left: parent.right
                anchors.top: parent.top
                anchors.leftMargin: -200
                anchors.topMargin: 620
                font.family: "Tahoma"

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        console.log("Lift Stop");
                        rosConnector.sendMessage(JSON.stringify({
                                                                    op: "publish",
                                                                    topic: "/linear_actuator_cmd",
                                                                    msg: {
                                                                        data: "x"
                                                                    }
                                                                }));
                        mstatusMessage.text = "Mechanism Stopped.";
                        mstatusMessage.color = "red";
                        mstatusMessage.visible = true;
                        mstatusTimer.start();
                    }
                }

                background: Rectangle {
                    color: "red"
                    radius: mechanismControl.buttonRadius
                }

                contentItem: Text {
                    text: parent.text
                    color: "white"
                    font.pointSize: parent.font.pointSize
                    font.family: parent.font.family
                    font.bold: false
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                    anchors.centerIn: parent
                }
            }
        }

        // Digital Twin
        Row {
            id: mcameraMapRow
            property real mapScalex: 59
            property real mapScaley: 48
            property real mapWidth: mdigitalTwinMap.width
            property real mapHeight: mdigitalTwinMap.height

            // Initial pixel anchor
            property real initialPixelX: 50
            property real initialPixelY: 90

            // Dynamic robot pose in pixels
            property real robotX: initialPixelX
            property real robotY: initialPixelY
            property real robotRotation: 0

            // AMCL origin to align ROS coordinates with pixel space
            property real originX: undefined
            property real originY: undefined

            // Convert from ROS meters to pixels
            function metersToPixelsX(x) {
                return (x - originX) * mapScalex + initialPixelX;
            }

            function metersToPixelsY(y) {
                return initialPixelY - (y - originY) * mapScaley;
            }

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 230
            anchors.rightMargin: 100
            spacing: 30

            Rectangle {
                id: mdigitalTwinMap
                width: 900
                height: 450
                color: "#f0f0f0"

                Image {
                    id: mmapImage
                    anchors.fill: parent
                    source: "qrc:/Images/map_with_shelves.png"
                }

                // Global path canvas
                Canvas {
                    id: mpathCanvas
                    anchors.fill: parent
                    property var globalPath: []

                    onPaint: {
                        var ctx = getContext("2d");
                        ctx.clearRect(0, 0, width, height);
                        ctx.lineWidth = 2;
                        ctx.strokeStyle = "blue";

                        if (globalPath.length > 1) {
                            ctx.beginPath();
                            ctx.moveTo(globalPath[0].x, globalPath[0].y);
                            for (var i = 1; i < globalPath.length; i++) {
                                ctx.lineTo(globalPath[i].x, globalPath[i].y);
                            }
                            ctx.stroke();
                        }
                    }
                }

                // Robot Icon
                Image {
                    id: mrobotIcon
                    source: "qrc:/Images/LiftRobot.png"
                    width: 40
                    height: 40
                    x: mcameraMapRow.robotX - width / 2
                    y: mcameraMapRow.robotY - height / 2
                    rotation: mcameraMapRow.robotRotation
                    transformOrigin: Item.Center
                    smooth: true
                    antialiasing: true
                }

                // Goal marker
                Image {
                    id: mgoalMarker
                    source: "qrc:/Images/flag.png"
                    width: 40
                    height: 40
                    visible: false
                    z: 10
                    smooth: true
                    antialiasing: true
                }
            }

            NumberAnimation on robotX { duration: 5 }
            NumberAnimation on robotY { duration: 5 }

            Connections {
                target: rosConnector

                function onPoseReceived(json) {
                    var pose = JSON.parse(json);
                    var x = pose.position.x;
                    var y = pose.position.y;
                    var q = pose.orientation;

                    if (mcameraMapRow.originX === undefined || mcameraMapRow.originY === undefined) {
                        mcameraMapRow.originX = x;
                        mcameraMapRow.originY = y;
                        console.log("Origin set to:", x, y);
                    }

                    mcameraMapRow.robotX = mcameraMapRow.metersToPixelsX(x);
                    mcameraMapRow.robotY = mcameraMapRow.metersToPixelsY(y);
                    mcameraMapRow.robotRotation = Math.atan2(2.0 * (q.w * q.z), 1.0 - 2.0 * (q.z * q.z)) * 180 / Math.PI;
                }

                function onGlobalPathReceived(json) {
                    var arr = JSON.parse(json);

                    if (mcameraMapRow.originX === undefined || mcameraMapRow.originY === undefined) {
                        console.log("Skipping path drawing until origin is known.");
                        return;
                    }

                    mpathCanvas.globalPath = arr.map(p => ({
                                                               x: mcameraMapRow.metersToPixelsX(p.pose.position.x),
                                                               y: mcameraMapRow.metersToPixelsY(p.pose.position.y)
                                                           }));
                    mpathCanvas.requestPaint();
                }

                function onGoalReceived(json) {
                    var goal = JSON.parse(json);
                    var x = goal.position.x;
                    var y = goal.position.y;

                    if (mcameraMapRow.originX === undefined || mcameraMapRow.originY === undefined)
                        return;

                    var pixelX = mcameraMapRow.metersToPixelsX(x);
                    var pixelY = mcameraMapRow.metersToPixelsY(y);

                    mgoalMarker.visible = true;
                    mgoalMarker.x = pixelX - mgoalMarker.width / 2;
                    mgoalMarker.y = pixelY - mgoalMarker.height / 2;

                    console.log("Goal marker placed at:", pixelX, pixelY);
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
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: Qt.PointingHandCursor
                onClicked: {
                    manualControlPage.visible = false
                    selectionPage.visible = true
                }
            }
        }
    }
}
