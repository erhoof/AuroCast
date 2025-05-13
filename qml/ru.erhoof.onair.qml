/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.me>
  SPDX-FileCopyrightText: 2023-2025 Pavel Bibichenko <b7086163@gmail.com>

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

    initialPage: Component { SubscriptionsPage { } }
    allowedOrientations: defaultAllowedOrientations
}
