/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtMultimedia 5.0
import Aurora.Controls 1.0
import "pages"
import "model"
import "service"

ApplicationWindow {
    cover: Qt.resolvedUrl("cover/CoverPage.qml")

    property var nowPlaying
    MediaPlayer {
        id: player
    }

    initialPage: Component {
        Page {
            allowedOrientations: defaultAllowedOrientations

            SplitView {
                id: splitView

                anchors.fill: parent
                splitter: Rectangle {
                    color: Theme.rgba(Theme.highlightColor, Theme.opacityLow)
                    width: 2
                }

                pinnedItem: SubscriptionsPage {}
                Item {
                    id: stationsList
                }

                Component.onCompleted: {
                    splitView.push(Qt.resolvedUrl("pages/SubscriptionsPage.qml"))
                    splitView.push(Qt.resolvedUrl("pages/EmptyPage.qml"))
                    //splitView.setMaxActiveItems(2)
                }
            }
        }
    }
}
