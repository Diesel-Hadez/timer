#include <QtQuick>
#include <QtWidgets>
#include <QQmlApplicationEngine>

int main(int argc, char* argv[]) {
	QQuickWindow::setDefaultAlphaBuffer(true);
	QApplication app(argc, argv);
	QQmlApplicationEngine engine(QStringLiteral("qrc:/main.qml"));

	if (engine.rootObjects().isEmpty()) {
		return -1;
	}
	return app.exec();
}
