/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

#include <QtQuick>

#include <auroraapp.h>

int main(int argc, char *argv[])
{
    // Aurora OS 4
    // return Aurora::Application::main(argc, argv);

    // Aurora OS 5
    QScopedPointer<QGuiApplication> application(Aurora::Application::application(argc, argv));
    application->setOrganizationName(QStringLiteral("ru.erhoof"));
    application->setApplicationName(QStringLiteral("On Air"));

    QScopedPointer<QQuickView> view(Aurora::Application::createView());

    // Aurora::Application::pathTo(QStringLiteral(...)) doesn't work
    // ("/usr/share/ru.erhoof.onair/qml/ru.erhoof.onair.qml"
    // pathToMainQml() -> "Document path '/usr/share/qml/.qml' is outside the workspace directory '/usr/share/ru.erhoof.onair'"
    //view->setSource(Aurora::Application::PackageFilesLocation + "qml/ru.erhoof.onair.qml");
    view->setSource(Aurora::Application::pathToMainQml());
    view->show();

    return application->exec();
}
