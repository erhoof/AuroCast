/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.me>
  SPDX-FileCopyrightText: 2023-2025 Pavel Bibichenko <b7086163@gmail.com>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import Aurora.Controls 1.0
import QtGraphicalEffects 1.0

import "../model"
import "../view"
import "../service"

Page {
    property var station
    property var episode

    ColumnLayout {
        anchors.margins: Theme.horizontalPageMargin
        anchors.fill: parent
        spacing: Theme.paddingLarge

        Rectangle {
            Layout.preferredWidth: 600
            Layout.preferredHeight: 600
            anchors.horizontalCenter: parent.horizontalCenter
            color: "transparent"
            Image {
                id: episodeImage
                source: episode.cover //episode.ownCover ? episode.cover : station.cover
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

        RowLayout {
            //Layout.preferredHeight: 120
            width: parent.width
            spacing: Theme.paddingMedium

            Rectangle {
                Layout.preferredWidth: 120
                Layout.preferredHeight: 120
                Layout.alignment: Qt.AlignLeft | Qt.AlignVCenter
                color: "transparent"
                Image {
                    id: stationImage
                    source: station.cover
                    anchors.fill: parent
                    fillMode: Image.PreserveAspectCrop

                    layer.enabled: true
                    layer.effect: OpacityMask {
                        maskSource: Rectangle {
                            width: stationImage.width
                            height: stationImage.height
                            radius: 10
                        }
                    }

                    BusyIndicator {
                        size: BusyIndicatorSize.Medium
                        anchors.centerIn: stationImage
                        running: stationImage.status != Image.Ready
                    }
                }
            }

            Column {
                Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
                Layout.fillWidth: true

                Label {
                    width: parent.width
                    elide: Text.ElideRight
                    font.pixelSize: Theme.fontSizeExtraSmall
                    color: Theme.secondaryHighlightColor
                    //font.bold: true
                    text: Qt.formatDateTime(new Date(episode.pubDate), "dd MMMM yyyy")
                }

                Label {
                    width: parent.width
                    elide: Text.ElideRight
                    text: episode.title
                }

                Label {
                    width: parent.width
                    elide: Text.ElideRight
                    text: station.title
                    color: Theme.secondaryColor
                    font.pixelSize: Theme.fontSizeSmall
                }
            }

            /*Button {
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                icon.source: "image://theme/icon-s-more"
            }*/
        }

        Column {
            anchors.left: parent.left
            anchors.right: parent.right
            Layout.maximumHeight: 100

            Slider {
                id: slider

                leftMargin: Theme.paddingSmall
                rightMargin: Theme.paddingSmall

                width: parent.width
                value: 0
                minimumValue: 0
                maximumValue: player.duration / 1000

                onReleased: {
                    player.seek(value * 1000);
                }
            }

            RowLayout {
                anchors {
                    left: parent.left
                    right: parent.right
                }

                Label {
                    id: positionLabel
                    text: "0:00"
                    elide: Text.ElideRight
                    font.pixelSize: Theme.fontSizeExtraSmall
                    Layout.preferredWidth: 100
                }

                Label {
                    id: remainingLabel
                    Layout.alignment: Qt.AlignRight
                    text: "-0:00"
                    horizontalAlignment: Text.AlignRight
                    font.pixelSize: Theme.fontSizeExtraSmall
                }
            }

            Timer {
                interval: 1000
                running: true
                repeat: true

                function formatTime(ms) {
                    var totalSeconds = Math.floor(ms / 1000);
                    var minutes = Math.floor(totalSeconds / 60);
                    var seconds = totalSeconds % 60;
                    return (minutes < 10 ? "0" + minutes : minutes) + ":" + (seconds < 10 ? "0" + seconds : seconds);
                }

                onTriggered: {
                    if (player.playbackState === MediaPlayer.PlayingState) {
                        slider.value = player.position / 1000;
                        positionLabel.text = formatTime(player.position);
                        remainingLabel.text = "-" + formatTime(player.duration - player.position)
                    }

                    if(player.playbackState === MediaPlayer.PlayingState) {
                        playPauseButton.icon.source = "image://theme/icon-l-circle-pause"
                    } else {
                        playPauseButton.icon.source = "image://theme/icon-l-play2"
                    }
                }
            }
        }

        Row {
            Layout.fillHeight: true
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            spacing: Theme.paddingLarge

            Label {
                width: 60
                horizontalAlignment: Qt.AlignCenter
                anchors.verticalCenter: parent.verticalCenter
                text: "x1"
                color: "gray"
            }

            IconButton {
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "image://theme/icon-m-10s-back"

                onClicked: {
                    player.seek(player.position - 10 * 1000);
                }
            }

            IconButton {
                id: playPauseButton
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "image://theme/icon-l-circle-pause"

                onClicked: {
                    if(player.playbackState === MediaPlayer.PlayingState) {
                        player.pause();
                        icon.source = "image://theme/icon-l-play2"
                    } else {
                        player.play();
                        icon.source = "image://theme/icon-l-circle-pause"
                    }
                }
            }

            IconButton {
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "image://theme/icon-m-10s-forward"

                onClicked: {
                    player.seek(player.position + 10 * 1000);
                }
            }

            IconButton {
                anchors.verticalCenter: parent.verticalCenter
                icon.source: "image://theme/icon-splus-night"
                enabled: false
            }
        }

        RowLayout {
            Layout.fillWidth: true

            Icon {
                source: "image://theme/icon-s-speaker-mute-1"
            }

            Slider {
                leftMargin: Theme.paddingLarge
                rightMargin: Theme.paddingLarge
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignCenter | Qt.AlignVCenter
                minimumValue: 0.0
                maximumValue: 1.0

                Component.onCompleted: {
                    value = player.volume;
                }

                onReleased: {
                    player.volume = value;
                }
            }

            Icon {
                source: "image://theme/icon-s-speaker"
            }
        }

        Row {
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: Theme.paddingLarge

            IconButton {
                icon.source: "image://theme/icon-splus-select-all"
                enabled: false
            }

            IconButton {
                icon.source: "image://theme/icon-splus-media-radio"
                enabled: false
            }

            IconButton {
                icon.source: "image://theme/icon-splus-list"
                enabled: false
            }
        }
    }
}
