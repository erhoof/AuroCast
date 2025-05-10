/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import Aurora.Controls 1.0

import "../view"
import "../model"

Page {
    Component {
        id: searchPage
        SearchPage {}
    }

    AppBar {
        id: header
        headerText: qsTr("Air")

        AppBarSpacer {}

        AppBarButton {
            icon.source: "image://theme/icon-m-refresh"
            onClicked: {
                subscriptionsModel.refresh()
            }
        }

        AppBarButton {
            icon.source: "image://theme/icon-m-add"
            onClicked: {
                pageStack.push(searchPage);
            }
        }
    }

    onStatusChanged: {
        if (PageStatus.Activating == status) {
            placeholderView.visible = !subscriptionsModel._stations.length
            subscriptionsListView.visible = subscriptionsModel._stations.length
        }
    }

    SilicaFlickable {
        id: placeholderView
        anchors.fill: parent

        ViewPlaceholder {
            anchors.centerIn: parent

            enabled: true
            text: qsTr("Subscriptions list is empty")
            hintText: qsTr("Search for some podcasts")
        }
    }

    StationsListView {
        id: subscriptionsListView
        anchors {
            fill: parent
            topMargin: header.height + Theme.paddingLarge
            margins: Theme.horizontalPageMargin
        }

        model: SubscriptionsListModel {
            id: subscriptionsModel
        }
    }
}
