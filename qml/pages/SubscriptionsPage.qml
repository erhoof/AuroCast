/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import Aurora.Controls 1.0
import "../model"
import "../view"

Item {
    //id: root
    //allowedOrientations: Orientation.Portrait | Orientation.Landscape | Orientation.LandscapeInverted

    Component {
        id: searchPage
        SearchPage {}
    }

    AppBar {
        id: appBarSubscriptions
        headerText: qsTr("Subscriptions")

        AppBarSpacer {}
        AppBarButton {
            context: qsTr("Add")
            icon.source: "image://theme/icon-m-new"

            onClicked: {
                splitView.pop(Qt.resolvedUrl("StationPage.qml"), SplitView.Immediate)
                splitView.push(Qt.resolvedUrl("SearchPage.qml"))
            }
        }
        AppBarButton {
            context: qsTr("Update")
            icon.source: "image://theme/icon-m-refresh"

            onClicked: {
                subscriptionsModel.refresh()
            }
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.topMargin: appBarSubscriptions.height
        width: parent.width

        StationsListView {
            id: subscriptionsListView
            clip: true
            model: SubscriptionsListModel {
                id: subscriptionsModel
            }
        }
    }
}
