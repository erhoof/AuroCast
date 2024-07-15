/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtMultimedia 5.0
import Sailfish.Silica 1.0
import "../model"
import "../view"
import "../service"

SilicaListView {
    /**
     * `Station`'s object episodes will be displayed in this ListView.
     */
    property var station

    id: view

    clip: true

    model: EpisodesListModel {
        station: view.station
    }

    delegate: Component {
        EpisodeListElement  {
            id: delegate
            onClicked: {
                var myUrl = Qt.resolvedUrl(model.enclosure);
                if (player.source.toString() === myUrl.toString()) {
                    if (player.playbackState === MediaPlayer.PlayingState) {
                        player.pause();
                    } else {
                        player.play();
                    }
                } else {
                    nowPlaying = station.episodes[index];
                    player.source = myUrl;
                    player.seek(0);
                    player.play();
                }
            }
        }
    }

    /*PullDownMenu {
        MenuItem {
            text: qsTr("Update")
            onClicked: view.station.reload()
        }
        quickSelect: true
        busy: view.station.status == Component.Loading
    }*/

    VerticalScrollDecorator {}

    /*ViewPlaceholder {
        id: loadingPlaceholder
        enabled: station.status === Component.Loading
        ColumnLayout {
            anchors.fill: loadingPlaceholder
            spacing: Theme.paddingMedium

            BusyIndicator {
                Layout.alignment: Qt.AlignHCenter

                size: BusyIndicatorSize.Large
                running: parent.enabled
            }
            InfoLabel {
                Layout.maximumWidth: view.width
                Layout.alignment: Qt.AlignHCenter

                text: qsTr("Loading...")
            }
        }
    }*/

    ViewPlaceholder {
        id: errorPlaceholder
        enabled: station.status === Component.Error
        ColumnLayout {
            anchors.fill: errorPlaceholder
            spacing: Theme.paddingMedium

            Image {
                Layout.alignment: Qt.AlignHCenter
                source: "image://theme/icon-l-attention"
            }
            InfoLabel {
                Layout.maximumWidth: view.width
                Layout.alignment: Qt.AlignHCenter

                text: qsTr("Error: could not fetch station data");
            }
        }
    }
}
