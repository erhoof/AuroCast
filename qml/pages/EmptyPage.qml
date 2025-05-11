/*
  SPDX-FileCopyrightText: 2023-2025 Pavel Bibichenko <b7086163@gmail.com>
  SPDX-FileCopyrightText: 2023-2025 Pavel Bibichenko <b7086163@gmail.com>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0

Item {
    id: emptyPage

    Column {
        height: parent.height
        width: parent.width
        spacing: Theme.paddingLarge

        Label {
            anchors.verticalCenter: parent.verticalCenter
            anchors.horizontalCenter: parent.horizontalCenter

            text: qsTr("No podcast is selected")
            font.pixelSize: Theme.fontSizeExtraLarge
            color: Theme.secondaryHighlightColor
            //font.family: Theme.fontFamilyHeading
        }
    }
}
