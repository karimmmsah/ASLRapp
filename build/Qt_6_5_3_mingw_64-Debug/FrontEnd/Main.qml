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
        Rectangle {
            x: 1100
            y: 55
            width: 266
            height: 57
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
            anchors.topMargin: 65
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
                            if (data.topic === "/hoverboard/connected") {
                                let status = data.msg.data;
                                updateStatus(status);
                            }
                        } catch (e) {
                            console.error("Error parsing message:", e);
                        }
                    }
                }

                function updateStatus(status) {
                    console.log("Status update:", status);
                    if (status === false) {
                        statusLabel.text = "Idle";
                        statusLabel.color = "orange";
                    } else if (status === true) {
                        statusLabel.text = "Busy";
                        statusLabel.color = "red";
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

                                    // Map 33V–42V to 0%–100%
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

        // Digital Twin
        Row {
            id: cameraMapRow
            property real mapScale: 100
            property real mapWidth: digitalTwinMap.width
            property real mapHeight: digitalTwinMap.height

            // Robot position and rotation
            property real robotX: mapWidth / 2 - 12.5 - 40
            property real robotY: mapHeight / 2 - 12.5 - 10
            property real robotRotation: 0

            // AMCL origin for relative positioning
            property real originX: undefined
            property real originY: undefined

            // Coordinate conversion from meters to pixels
            function metersToPixelsX(x) {
                return (x - originX) * mapScale + mapWidth / 2;
            }

            function metersToPixelsY(y) {
                return mapHeight / 2 - (y - originY) * mapScale;
            }

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 200
            anchors.rightMargin: 100
            spacing: 30

            Rectangle {
                id: digitalTwinMap
                width: 600
                height: 350
                color: "#f0f0f0"

                Image {
                    id: mapImage
                    anchors.fill: parent
                    source: "qrc:/Images/mapsmallwarehousec.png"
                }

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
                    source: "qrc:/Images/robot_icon.png"
                    width: 25
                    height: 25
                    x: cameraMapRow.robotX
                    y: cameraMapRow.robotY
                    rotation: cameraMapRow.robotRotation
                    transformOrigin: Item.Center
                    smooth: true
                    antialiasing: true
                }
            }

            NumberAnimation on robotX {
                id: robotIconNumberAnimationX
                duration: 200
            }

            NumberAnimation on robotY {
                id: robotIconNumberAnimationY
                duration: 200
            }

            Connections {
                target: rosConnector

                function onPoseReceived(json) {
                    var pose = JSON.parse(json);
                    var x = pose.position.x;
                    var y = pose.position.y;
                    var q = pose.orientation;

                    console.log("Received Robot Position -> X:", x, "Y:", y);

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
            }
        }

        // Pick, Drop, QR Scan
        Column {
            id: mLeftControlColumn
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 150
            anchors.rightMargin: 80
            spacing: 50

            // Pick Section
            Column {
                spacing: 10

                Label {
                    text: "START"
                    font.pointSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    font.italic: false
                    font.underline: false
                }

                ComboBox {
                    id: mShelfDropdown
                    width: 170
                    height: 40
                    model: ["Shelf A", "Shelf B", "Shelf C"]

                    background: Rectangle {
                        color: "#bbc4ca"
                        radius: 8
                    }

                    contentItem: Text {
                        text: mShelfDropdown.currentText
                        color: "black"
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    indicator: Rectangle {
                        width: 20
                        height: 20
                        radius: 5
                        color: "black"
                        anchors.right: parent.right
                        anchors.rightMargin: 10
                        anchors.top: parent.top
                        anchors.topMargin: 10
                    }
                }
            }

            // Drop Section
            Column {
                spacing: 10

                Label {
                    text: "END"
                    font.pointSize: 16
                    font.bold: true
                    horizontalAlignment: Text.AlignHCenter
                    font.underline: false
                    font.italic: false
                }

                ComboBox {
                    id: mLocationDropdown
                    width: 170
                    height: 40
                    model: ["Location 1", "Location 2", "Location 3"]

                    background: Rectangle {
                        color: "#bbc4ca"
                        radius: 8
                    }

                    contentItem: Text {
                        text: mLocationDropdown.currentText
                        color: "black"
                        font.pointSize: 14
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignHCenter
                    }

                    indicator: Rectangle {
                        width: 20
                        height: 20
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

        // QR Scan
        Item {
            id: qrScanner
            width: parent.width
            height: parent.height

            property bool cameraVisible: false
            property real cameraWidth: cameraVisible ? 600 : 0
            property real cameraHeight: cameraVisible ? 500 : 0

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

            Button {
                id: toggleButton
                width: 160
                height: 50
                x: parent.width - width - 90
                y: 420
                text: qrScanner.cameraVisible ? "CLOSE QR CAMERA" : "OPEN QR CAMERA"

                font.pointSize: 12
                font.bold: true

                background: Rectangle {
                    color: qrScanner.cameraVisible ? "#388E3C" : "#008080"  // Red when open, green when closed
                    radius: 12
                }

                contentItem: Text {
                    text: toggleButton.text
                    color: "white"
                    font: toggleButton.font
                    horizontalAlignment: Text.AlignHCenter
                    verticalAlignment: Text.AlignVCenter
                }

                onClicked: {
                    qrScanner.cameraVisible = !qrScanner.cameraVisible
                }
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
            font.pointSize: 13
            font.family: "Tahoma"

            anchors.right: parent.right
            anchors.top: parent.top
            anchors.rightMargin: 90
            anchors.topMargin: 520

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

            onClicked: console.log("Emergency Stop Triggered!") &
                       rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}') &
                       rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}')
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
                    if (manualControlPage.visible === true) keyHandler.forceActiveFocus();
                }

                Keys.onPressed: (event) => {
                                    event.accepted = true;

                                    switch (event.key) {
                                        case 16777235: // Numpad 8
                                        console.log("Move Forward");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        break;
                                        case 16777237: // Numpad 2
                                        console.log("Move Backward");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        break;
                                        case 16777234: // Numpad 4
                                        console.log("Move Left");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        break;
                                        case 16777236: // Numpad 6
                                        console.log("Move Right");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        break;
                                        case 16777233: // Numpad 7
                                        console.log("Move North-West");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        break;
                                        case 16777239: // Numpad 9
                                        console.log("Move North-East");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        break;
                                        case 16777232: // Numpad 1
                                        console.log("Move South-West");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}');
                                        break;
                                        case 16777238: // Numpad 3
                                        console.log("Move South-East");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}');
                                        break;
                                        case 16777227: // Numpad 5
                                        console.log("STOP");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}');
                                        break;
                                        case Qt.Key_A: // A key for Ascend
                                        console.log("Lift Ascend");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/linear_actuator_cmd","msg":{"data":"0"}}');
                                        break;
                                        case Qt.Key_D: // D key for Descend
                                        console.log("Lift Descend");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/linear_actuator_cmd","msg":{"data":"1"}}');
                                        break;
                                        case Qt.Key_X: // X key for Lift Stop
                                        console.log("Lift Stop");
                                        rosConnector.sendMessage('{"op":"publish","topic":"/linear_actuator_cmd","msg":{"data":"x"}}');
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
                        onClicked: console.log("Move North-West") &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}') &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}')
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "↑"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move Forward") &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}') &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}')
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "↗"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move North-East") &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}') &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}')
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
                        onClicked: console.log("Move Left") &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}') &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}')
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "STOP"
                        width: controlPanel.stopSize
                        height: controlPanel.stopSize
                        font.pointSize: 16
                        onClicked: console.log("STOP") &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}') &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}')
                        background: Rectangle { color: "red"; radius: 10 }
                    }

                    Button {
                        text: "→"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move Right") &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}') &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":0.0,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}')
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
                        onClicked: console.log("Move South-West") &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}') &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":-0.5}}}')
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "↓"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move Backward") &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}') &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.0}}}')
                        background: Rectangle { color: "#bbc4ca"; radius: 10 }
                    }

                    Button {
                        text: "↘"
                        width: controlPanel.buttonSize
                        height: controlPanel.buttonSize
                        font.pointSize: 22
                        onClicked: console.log("Move South-East") &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}') &
                                   rosConnector.sendMessage('{"op":"publish","topic":"/hoverboard_velocity_controller/cmd_vel","msg":{"linear":{"x":-0.5,"y":0.0,"z":0.0},"angular":{"x":0.0,"y":0.0,"z":0.5}}}')
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
                onClicked: {
                    console.log("Lift Ascend");
                    rosConnector.sendMessage(JSON.stringify({
                                                                op: "publish",
                                                                topic: "/linear_actuator_cmd",
                                                                msg: {
                                                                    data: "0"
                                                                }
                                                            }));
                }

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
                onClicked: {
                    console.log("Lift Descend");
                    rosConnector.sendMessage(JSON.stringify({
                                                                op: "publish",
                                                                topic: "/linear_actuator_cmd",
                                                                msg: {
                                                                    data: "1"
                                                                }
                                                            }));
                }

                background: Rectangle {
                    color: "#bbc4ca"
                    radius: mechanismControl.buttonRadius
                }
            }
            // Stop Button
            Button {
                id: stoplift
                width: 100
                text: "Stop"
                focusPolicy: Qt.NoFocus
                height: mechanismControl.buttonHeight
                font.pointSize: 16
                anchors.left: parent.right
                anchors.top: parent.top
                anchors.leftMargin: -200
                anchors.topMargin: 600
                font.family: "Tahoma"
                onClicked: {
                    console.log("Stop Lift");
                    rosConnector.sendMessage(JSON.stringify({
                                                                op: "publish",
                                                                topic: "/linear_actuator_cmd",
                                                                msg: {
                                                                    data: "x"
                                                                }
                                                            }));
                }

                background: Rectangle {
                    color: "#bbc4ca"
                    radius: mechanismControl.buttonRadius
                }
            }
        }

        // Digital Twin
        Row {
            id: mCameraMapRow
            property real mapScale: 100
            property real mapWidth: mDigitalTwinMap.width
            property real mapHeight: mDigitalTwinMap.height

            // Robot position and rotation
            property real robotX: mapWidth / 2 - 12.5 - 40
            property real robotY: mapHeight / 2 - 12.5 - 10
            property real robotRotation: 0

            // AMCL origin for relative positioning
            property real originX: undefined
            property real originY: undefined

            // Coordinate conversion from meters to pixels
            function metersToPixelsX(x) {
                return (x - originX) * mapScale + mapWidth / 2;
            }

            function metersToPixelsY(y) {
                return mapHeight / 2 - (y - originY) * mapScale;
            }

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.right: parent.right
            anchors.topMargin: 200
            anchors.rightMargin: 50
            spacing: 30

            Rectangle {
                id: mDigitalTwinMap
                width: 600
                height: 350
                color: "#f0f0f0"

                Image {
                    id: mMapImage
                    anchors.fill: parent
                    source: "qrc:/Images/mapsmallwarehousec.png"
                }

                Canvas {
                    id: mPathCanvas
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
                    id: mRobotIcon
                    source: "qrc:/Images/robot_icon.png"
                    width: 25
                    height: 25
                    x: mCameraMapRow.robotX
                    y: mCameraMapRow.robotY
                    rotation: mCameraMapRow.robotRotation
                    transformOrigin: Item.Center
                    smooth: true
                    antialiasing: true
                }
            }

            NumberAnimation on robotX {
                id: mRobotIconNumberAnimationX
                duration: 200
            }

            NumberAnimation on robotY {
                id: mRobotIconNumberAnimationY
                duration: 200
            }

            Connections {
                target: rosConnector

                function onPoseReceived(json) {
                    var pose = JSON.parse(json);
                    var x = pose.position.x;
                    var y = pose.position.y;
                    var q = pose.orientation;

                    console.log("Received Robot Position -> X:", x, "Y:", y);

                    if (mCameraMapRow.originX === undefined || mCameraMapRow.originY === undefined) {
                        mCameraMapRow.originX = x;
                        mCameraMapRow.originY = y;
                        console.log("Origin set to:", x, y);
                    }

                    mCameraMapRow.robotX = mCameraMapRow.metersToPixelsX(x);
                    mCameraMapRow.robotY = mCameraMapRow.metersToPixelsY(y);
                    mCameraMapRow.robotRotation = Math.atan2(
                                2.0 * (q.w * q.z),
                                1.0 - 2.0 * (q.z * q.z)
                                ) * 180 / Math.PI;
                }

                function onGlobalPathReceived(json) {
                    var arr = JSON.parse(json);

                    if (mCameraMapRow.originX === undefined || mCameraMapRow.originY === undefined) {
                        console.log("Skipping path drawing until origin is known.");
                        return;
                    }

                    mPathCanvas.globalPath = arr.map(p => ({
                                                               x: mCameraMapRow.metersToPixelsX(p.pose.position.x),
                                                               y: mCameraMapRow.metersToPixelsY(p.pose.position.y)
                                                           }));
                    mPathCanvas.requestPaint();
                }
            }
        }

        // Status & Battery Display
        Column {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: parent.top
            anchors.topMargin: 20
            spacing: 10

            //  Status Display
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

                    onMessageReceived: function(message) {
                        try {
                            let data = JSON.parse(message);
                            console.log("Received message for status:", data);
                            if (data.topic === "/hoverboard/connected") {
                                let status = data.msg.data;
                                updateStatus(status);
                            }
                        } catch (e) {
                            console.error("Error parsing message:", e);
                        }
                    }
                }

                function updateStatus(status) {
                    console.log("Status update:", status);
                    if (status === false) {
                        mstatusLabel.text = "Idle";
                        mstatusLabel.color = "orange";
                    } else if (status === true) {
                        mstatusLabel.text = "Busy";
                        mstatusLabel.color = "red";
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

                                    // Map 33V–42V to 0%–100%
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
