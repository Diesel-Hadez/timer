import QtQuick 2.15
import QtQuick.Window 2.15
import Qt.labs.platform 1.0

Window {
	id: root
	visible: true
	// WA_TranslucentBackground isn't actually needed in my tests
	flags: Qt.FramelessWindowHint | Qt.WA_TranslucentBackground | Qt.WindowStaysOnTopHint
	width: 300
	height: 100
	color: "#00000000"
	Item {
		id: timerRoot
		property int elapsed: 0
		property int seconds: timerRoot.elapsed % 60
		property int minutes: Math.floor(elapsed / 60) % 60
		property int hours: Math.floor(elapsed / 3600)

		// alias maybe?
		property bool running: false
		property bool started: false
		property int interval: 0
		anchors.fill: parent
		anchors.margins: 5
		Rectangle {
			anchors.fill: parent
			border.color: "#FFFF69B4"
			color: "#00000000"

			Text {
				color: "white"
				font.family: "Helvetica"
				font.pointSize: 24
				anchors.centerIn: parent
				text: String(timerRoot.hours).padStart(2, '0') + ":" + 
					String(timerRoot.minutes).padStart(2, '0') + ":" +
					String(timerRoot.seconds).padStart(2, '0') 
			}
		}

		Timer {
			id: myTimer
			interval: 1000
			running: false
			repeat: true
			onTriggered: {timerRoot.elapsed++;}
		}

		function reset() {
			myTimer.running = started = false;
			timerRoot.seconds = 0;
		}

		function pause() {
			timerRoot.running = myTimer.running = false;
		}

		function resume() {
			timerRoot.running = myTimer.running = true;
		}

	}

	// Thanks https://stackoverflow.com/a/40737227
	MouseArea {
		id: mouseArea
		property int prevX: 0
		property int prevY: 0
		anchors.fill: parent
		onPressed: { prevX = mouse.x; prevY = mouse.y; }
		onPositionChanged: {
			const deltaX = mouse.x - prevX;
			const deltaY = mouse.y - prevY;

			root.x += deltaX;
			root.y += deltaY;

			prevX = mouse.x - deltaX;
			prevY = mouse.y - deltaY;
		}
	}

	MouseArea {
		anchors.fill: parent
		acceptedButtons: Qt.RightButton
		onClicked: startMenu.open()
	}

	Menu {
		id: startMenu

		MenuItem {
			text: timerRoot.started ? ( timerRoot.running ? qsTr("Pause") : qsTr("Resume") ) : qsTr("Start")
			font.pointSize: 16
			onTriggered: {
				if (!timerRoot.started) {
					timerRoot.started = true;
					timerRoot.resume();
				}
				else if (timerRoot.running) {
					timerRoot.pause();
				}
				else {
					timerRoot.resume();
				}


			}
		}

		MenuItem {
			visible: !timerRoot.running && timerRoot.started
			text: qsTr("Reset")
			font.pointSize: 16
			onTriggered: timerRoot.reset()
		}

		MenuItem {
			text: qsTr("Exit")
			font.pointSize: 16
			onTriggered: Qt.quit()
		}
	}
}
