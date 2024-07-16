/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtQuick.Layouts 1.1
import Aurora.Controls 1.0
import "../view"
import "../service"
import "../model"

Item {
    //id: root

    //property bool _firstRun: true

    /*onStatusChanged: {
        if (_firstRun && status === PageStatus.Active) {
            _firstRun = false;
            view.headerItem.forceActiveFocus();
        }
    }*/

    AppBar {
        id: appBarSearch
        headerText: qsTr("Search")

        AppBarSpacer {}
        AppBarButton {
            context: qsTr("RSS")
            text: qsTr("Добавить по RSS")
            //icon.source: "image://theme/icon-m-new"

            onClicked: {
                //splitView.pop(SplitView.Immediate)
                //splitView.push(Qt.resolvedUrl("SearchPage.qml"))
                pageStack.push(addByRssUrlDialog)
            }
        }
    }

    StationsListView {
        id: view

        anchors.fill: parent
        anchors.topMargin: appBarSearch.height

        header: SearchField {
            width: parent.width

            placeholderText: qsTr("Search iTunes Store")

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
                    listModel.setStations(results.stations);
                };
                ITunes.search(query, callback);
            }

            onTextChanged: {
                if (text === "") {
                    listModel.clear();
                }
            }
        }

        // prevent newly added list delegates from stealing focus away from the search field
        currentIndex: -1

        model: StationsListModel {
            id: listModel
        }
    }

    Dialog {
        id: addByRssUrlDialog
        allowedOrientations: defaultAllowedOrientations

        canAccept: Qt.resolvedUrl(urlText.text).indexOf("http") === 0

        DialogHeader {
            acceptText: qsTr("Add")
        }
        TextField {
            id: urlText

            anchors {
                centerIn: parent
                leftMargin: Theme.horizontalPageMargin
                rightMargin: Theme.horizontalPageMargin
            }
            width: parent.width

            label: qsTr("RSS url")
            placeholderText: label
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
