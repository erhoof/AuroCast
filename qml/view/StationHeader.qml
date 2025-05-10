/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0

import "../service"

ColumnLayout {
    id: header

    anchors.fill: parent
    anchors.margins: Theme.horizontalPageMargin

    spacing: Theme.paddingLarge

    //Layout.preferredHeight: 480
    //Layout.maximumHeight: 480
    //Layout.minimumHeight: 480

    property var station
    property bool subscribed

    Column {
        id: column
        width: parent.width - Theme.horizontalPageMargin
        spacing: Theme.paddingMedium
        clip: true

        Image {
            id: image
            anchors.horizontalCenter: parent.horizontalCenter
            source: station.cover

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    width: image.width
                    height: image.height
                    radius: 10
                }
            }

            BusyIndicator {
                size: BusyIndicatorSize.Medium
                anchors.centerIn: image
                running: image.status != Image.Ready
            }
        }
    }

    /*RowLayout {
        anchors.fill: parent
        Layout.fillWidth: true

        spacing: Theme.paddingMedium

        Image {
            Layout.alignment: Qt.AlignTop | Qt.AlignLeft

            Layout.preferredWidth: Theme.iconSizeExtraLarge * 1.2
            Layout.preferredHeight: Theme.iconSizeExtraLarge * 1.2

            fillMode: Image.PreserveAspectCrop

            source: header.station.cover
        }

        ColumnLayout {
            Label {
                Layout.fillWidth: true

                color: Theme.primaryColor
                wrapMode: Text.WordWrap
                truncationMode: TruncationMode.Elide
                font.bold: true

                text: header.station.title
            }

            Label {
                Layout.fillHeight: true

                font.pixelSize: Theme.fontSizeSmall
                color: Theme.secondaryColor

                text: "iTunes"
            }
        }
    }

    RowLayout {
        spacing: Theme.paddingMedium

        Button {
            text: header.subscribed
                ? qsTr("Unsubscribe")
                : qsTr("Subscribe")
            enabled: header.subscribed || (header.station.status === Component.Ready)

            onClicked: {
                var url = header.station.feed_url.toString();
                if (header.subscribed) {
                    Dao.unsubscribe(url);
                } else {
                    Dao.subscribe(url);
                }
            }
        }

        Button {
            icon.source: "image://theme/icon-s-retweet"
        }
    }

    function _update() {
        Dao.isSubscribed(station.feed_url.toString(), function (flag) {
            header.subscribed = flag;
        });
    }

    onStationChanged: _update()
    Component.onCompleted: {
        _update();
        Dao.subscription.connect(function(url, flag) {
            if (url === station.feed_url.toString()) {
                header.subscribed = flag;
            }
        });
    }

    Label {
        Layout.fillWidth: true

        maximumLineCount: 2
        wrapMode: Text.Wrap
        font.pixelSize: Theme.fontSizeSmall
        elide: Text.ElideMiddle

        text: header.station.description
    }

    Label {
        Layout.fillWidth: true

        font.pixelSize: Theme.fontSizeTiny
        color: Theme.secondaryColor

        text: qsTr("Доступно эпизодов: ") + header.station.episodes.length
    }*/
}
