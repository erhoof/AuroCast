/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <auroraapp.h>

int main(int argc, char *argv[])
{
    // Aurora OS 4
    // return Aurora::Application::main(argc, argv);

    // Aurora OS 5
    QScopedPointer<QGuiApplication> application(Aurora::Application::application(argc, argv));
    application->setOrganizationName(QStringLiteral("com.gthub.erhoof"));
    application->setApplicationName(QStringLiteral("aurocast"));

    QScopedPointer<QQuickView> view(Aurora::Application::createView());

    // Aurora::Application::pathTo(QStringLiteral(...)) doesn't work
    // ("/usr/share/com.github.erhoof.aurocast/qml/com.github.erhoof.aurocast.qml"
    // pathToMainQml() -> "Document path '/usr/share/qml/.qml' is outside the workspace directory '/usr/share/com.github.erhoof.aurocast'"
    //view->setSource(Aurora::Application::PackageFilesLocation + "qml/com.github.erhoof.aurocast.qml");
    view->setSource(Aurora::Application::pathToMainQml());
    view->show();

    return application->exec();
}
