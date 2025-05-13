/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.me>
  SPDX-FileCopyrightText: 2023-2025 Pavel Bibichenko <b7086163@gmail.com>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import QtGraphicalEffects 1.0

CoverBackground {
    GridLayout {
        anchors.fill: parent
        anchors.margins: Theme.paddingMedium
        anchors.topMargin: 0
        anchors.bottomMargin: 120 // cover buttons
        columns: 1 // on Aurora 5 make it 2

        Rectangle {
            Layout.preferredWidth: Theme.iconSizeLarge
            Layout.preferredHeight: Theme.iconSizeLarge
            color: "transparent"
            visible: nowPlaying ? true : false
            Image {
                id: episodeImage
                source: nowPlaying ? nowPlaying.cover : "" //episode.ownCover ? episode.cover : station.cover
                anchors.fill: parent
                fillMode: Image.PreserveAspectCrop

                layer.enabled: true
                layer.effect: OpacityMask {
                    maskSource: Rectangle {
                        width: episodeImage.width
                        height: episodeImage.height
                        radius: 10
                    }
                }

                BusyIndicator {
                    size: BusyIndicatorSize.Medium
                    anchors.centerIn: episodeImage
                    running: episodeImage.status != Image.Ready
                }
            }
        }


        /*Image {
            id: coverImage

            Layout.preferredWidth: Theme.iconSizeLarge
            Layout.preferredHeight: Theme.iconSizeLarge

            fillMode: Image.PreserveAspectCrop
            visible: nowPlaying ? true : false

            source: nowPlaying ? nowPlaying.cover : "image://theme/icon-m-share-sign"
        }*/

        Label {
            id: titleLabel
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft

            wrapMode: Text.Wrap
            font.pixelSize: Theme.fontSizeSmall
            elide: Text.ElideRight
            maximumLineCount: 2
            color: Theme.primaryColor

            text: nowPlaying ? nowPlaying.station.title : qsTr("Nothing is playing")
        }

        Label {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft

            wrapMode: Text.Wrap
            font.pixelSize: Theme.fontSizeTiny
            elide: Text.ElideMiddle
            color: Theme.secondaryColor
            maximumLineCount: 4 - titleLabel.lineCount

            text: nowPlaying ? nowPlaying.title : qsTr("Play your first podcast")
        }
    }

    CoverActionList {
        enabled: nowPlaying && (player.playbackState === MediaPlayer.PlayingState)

        CoverAction {
            iconSource: "image://theme/icon-cover-previous-song"
            onTriggered: player.seek(player.position - 15000)
        }

        CoverAction {
            iconSource: !(player.playbackState === MediaPlayer.PlayingState) ? "image://theme/icon-cover-play" : "image://theme/icon-cover-pause"
            onTriggered: !(player.playbackState === MediaPlayer.PlayingState) ? player.play() : player.pause()
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-next-song"
            onTriggered: player.seek(player.position + 30000)
        }
    }

    CoverActionList {
        enabled: nowPlaying && (player.playbackState === MediaPlayer.PausedState)

        CoverAction {
            iconSource: "image://theme/icon-cover-play"
            onTriggered: player.play()
        }
    }

    CoverActionList {
        enabled: !nowPlaying
    }
}
