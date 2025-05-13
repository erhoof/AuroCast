/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.me>
  SPDX-FileCopyrightText: 2023-2025 Pavel Bibichenko <b7086163@gmail.com>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.Layouts 1.1
import Aurora.Controls 1.0
import "../view"
import "../service"
import "../model"

Page {
    AppBar {
        id: appBarSearch

        AppBarSearchField {
            id: searchField
            placeholderText: qsTr("Podcast name")

            Component.onCompleted: focus = true

            EnterKey.enabled: text.length > 0
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: {
                focus = false;

                var query = text.trim();
                if (query === "") return;

                // do request to iTunes Store
                // pass callback
                var callback = function(results) {
                    // parse results, push parsed results into list model and refresh page
                    searchListModel.setStations(results.stations);
                    placeholderView.visible = !results.stations.length
                };
                ITunes.search(query, callback);
            }

            onTextChanged: {
                if (text === "") {
                    listModel.clear();
                }
            }
        }

        AppBarButton {
            icon.source: "image://theme/icon-m-website"
            onClicked: {
                pageStack.push(addByRssUrlDialog)
            }
        }
    }

    SilicaFlickable {
        id: placeholderView
        anchors.fill: parent

        visible: true

        ViewPlaceholder {
            anchors.centerIn: parent

            enabled: true
            text: qsTr("Nothing to show")
            hintText: qsTr("Input or change search query")
        }
    }

    StationsListModel {
        id: searchListModel
    }

    StationsListView {
        id: view

        anchors {
            top: appBarSearch.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right

            margins: Theme.horizontalPageMargin
        }

        // prevent newly added list delegates from stealing focus away from the search field
        currentIndex: -1

        model: searchListModel
    }

    Dialog {
        id: addByRssUrlDialog
        allowedOrientations: defaultAllowedOrientations

        canAccept: Qt.resolvedUrl(urlText.text).indexOf("http") === 0

        DialogHeader {
            id: dialogHeader
            acceptText: qsTr("Add by RSS")
        }

        TextField {
            id: urlText

            anchors {
                top: dialogHeader.bottom
                leftMargin: Theme.horizontalPageMargin
                rightMargin: Theme.horizontalPageMargin
            }
            width: parent.width

            placeholderText: qsTr("Input RSS Link")
            EnterKey.enabled: addByRssUrlDialog.canAccept
            EnterKey.iconSource: "image://theme/icon-m-enter-next"
            EnterKey.onClicked: addByRssUrlDialog.accept()

            text: ""
        }

        acceptDestination: Component {
            StationPage {
                station: Dao.emptyStation(this);
            }
        }

        onAcceptPendingChanged: {
            acceptDestinationInstance.station = Dao.stationFromUrl(acceptDestinationInstance, urlText.text);
        }
    }
}
