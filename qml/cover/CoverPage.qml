/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

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
        anchors.bottomMargin: 100 // cover buttons
        columns: 1 // on Aurora 5 make it 2

        Image {
            id: coverImage

            Layout.preferredWidth: Theme.iconSizeExtraLarge
            Layout.preferredHeight: Theme.iconSizeExtraLarge

            fillMode: Image.PreserveAspectCrop
            visible: nowPlaying ? true : false

            source: nowPlaying ? nowPlaying.cover : "image://theme/icon-m-share-sign"
        }

        Label {
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft

            wrapMode: Text.Wrap
            font.pixelSize: Theme.fontSizeSmall
            elide: Text.ElideRight
            maximumLineCount: 2

            text: nowPlaying ? nowPlaying.station.title : qsTr("Ничего не играет")
        }

        Label {
            Layout.fillHeight: true
            Layout.preferredWidth: parent.width
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft

            wrapMode: Text.Wrap
            font.pixelSize: Theme.fontSizeTiny
            elide: Text.ElideMiddle

            text: nowPlaying ? nowPlaying.title : qsTr("Послушайте ваш первый подкаст")
        }
    }

    CoverActionList {
        CoverAction {
            iconSource: "image://theme/icon-cover-previous-song"
            onTriggered: player.seek(player.position - 10000)
        }

        CoverAction {
            iconSource: !(player.playbackState === MediaPlayer.PlayingState) ? "image://theme/icon-cover-play" : "image://theme/icon-cover-pause"
            onTriggered: !(player.playbackState === MediaPlayer.PlayingState) ? player.play() : player.pause()
        }

        CoverAction {
            iconSource: "image://theme/icon-cover-next-song"
            onTriggered: player.seek(player.position + 10000)
        }
    }
}
