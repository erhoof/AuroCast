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
    id: stationPage

    property var station
    property bool subscribed

    AppBar {
        id: appBar
        headerText: station.title
    }

    SilicaFlickable {
        anchors {
            top: appBar.bottom
            bottom: parent.bottom
            left: parent.left
            right: parent.right

            topMargin: Theme.paddingMedium
            leftMargin: Theme.horizontalPageMargin
        }

        contentHeight: column.height + Theme.paddingLarge

        VerticalScrollDecorator { flickable: column }

        Column {
            id: column
            width: parent.width - Theme.horizontalPageMargin
            spacing: Theme.paddingMedium
            clip: true

            Image {
                id: image
                anchors.horizontalCenter: parent.horizontalCenter
                source: station.cover
                width: 400
                height: 400
                fillMode: Image.PreserveAspectCrop

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

            RowLayout {
                width: parent.width
                spacing: Theme.paddingMedium

                Button {
                    Layout.fillWidth: true

                    text: subscribed
                        ? qsTr("Unsubscribe")
                        : qsTr("Subscribe")
                    icon.source: subscribed ? "image://theme/icon-m-mail-send" : "image://theme/icon-m-mail-inbox"
                    enabled: subscribed || (station.status === Component.Ready)

                    onClicked: {
                        if(!station || !station.feed_url) {
                            return;
                        }

                        var url = station.feed_url.toString();
                        if (subscribed) {
                            Dao.unsubscribe(url);
                            subscribed = false;
                        } else {
                            Dao.subscribe(url);
                            subscribed = true;
                        }
                    }
                }

                Button {
                    icon.source: "image://theme/icon-s-more"
                    enabled: false
                }

                function _update() {
                    if(!station || !station.feed_url) {
                        return;
                    }

                    Dao.isSubscribed(station.feed_url.toString(), function (flag) {
                        subscribed = flag;
                    });
                }

                Component.onCompleted: {
                    _update();
                    /*Dao.subscription.connect(function(url, flag) {
                        if(!station || !station.feed_url) {
                            return;
                        }

                        if (url === station.feed_url.toString()) {
                            subscribed = flag;
                        }
                    });*/
                }
            }

            Rectangle {
                width: parent.width
                height: infoColumn.height + Theme.paddingMedium * 1.5
                color: Qt.rgba(1, 1, 1, 0.2)
                radius: 8

                Column {
                    id: infoColumn
                    anchors.verticalCenter: parent.verticalCenter
                    anchors {
                        left: parent.left
                        right: parent.right
                        margins: Theme.paddingMedium
                    }

                    Label {
                        width: parent.width
                        text: station.title
                        wrapMode: Text.WordWrap
                    }

                    Label {
                        color: Theme.secondaryColor
                        text: station.author
                        font.pixelSize: Theme.fontSizeSmall
                    }

                    Rectangle {
                        width: parent.width
                        height: Theme.paddingLarge
                        color: "transparent"
                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width
                            height: 2
                            color: Theme.secondaryColor
                            opacity: 0.8
                        }
                    }

                    RowLayout {
                        Label {
                            text: qsTr("Episodes:")
                            font.pixelSize: Theme.fontSizeSmall
                        }

                        Label {
                            color: Theme.secondaryColor
                            text: station.episodes.length
                            font.pixelSize: Theme.fontSizeSmall
                        }
                    }

                    Label {
                        text: qsTr("Copyright:")
                        font.pixelSize: Theme.fontSizeSmall
                    }

                    Text {
                        width: parent.width
                        color: Theme.secondaryColor
                        text: station.copyright
                        font.pixelSize: Theme.fontSizeSmall

                        wrapMode: Text.WordWrap
                        elide: Text.ElideRight
                    }
                }
            }

            Text {
                id: description
                width: parent.width

                color: Theme.secondaryColor
                text: stripHtmlTags(station.description)
                wrapMode: Text.WordWrap
                elide: Text.ElideRight

                function stripHtmlTags(html) {
                    html = html.replace(/<br\s*\/?>/gi, "\n");
                    html = html.replace(/<\/?p\s*\/?>/gi, "");
                    return html
                }
            }

            EpisodesListView {
                width: parent.width
                station: stationPage.station
            }
        }
    }
}
