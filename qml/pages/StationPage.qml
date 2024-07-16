/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import "../model"
import "../view"
import "../service"

Item {
    id: stationPage

    property var station

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 0
        spacing: 0

        StationHeader {
            station: stationPage.station
        }

        Item {
            height: 35
        }

        EpisodesListView {
            Layout.fillHeight: true
            Layout.fillWidth: true

            station: stationPage.station
        }
    }
}
