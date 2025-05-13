/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.me>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import QtMultimedia 5.0
import Sailfish.Silica 1.0

BackgroundItem {
    id: element

    property bool isCurrent: Qt.resolvedUrl(model.enclosure).toString() === player.source.toString()

    width: parent.width
    height: 220

    Rectangle {
        anchors.fill: parent
        color: Qt.rgba(1, 1, 1, 0.2)
        radius: 8

        Column {
            anchors.verticalCenter: parent.verticalCenter
            anchors {
                left: parent.left
                right: parent.right
                margins: Theme.paddingMedium
            }

            Text {
                id: titleText
                width: parent.width
                text: model.title
                color: Theme.primaryColor
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                maximumLineCount: 2
                elide: Text.ElideRight
            }

            Text {
                width: parent.width
                text: stripHtmlTags(model.description)
                color: Theme.secondaryColor
                wrapMode: Text.WrapAtWordBoundaryOrAnywhere
                maximumLineCount: 4 - titleText.lineCount
                elide: Text.ElideRight
                font.pixelSize: Theme.fontSizeSmall
                textFormat: Text.PlainText

                function stripHtmlTags(html) {
                    html = html.replace(/<br\s*\/?>/gi, "");
                    html = html.replace(/<\/?p\s*\/?>/gi, "");
                    html = html.replace(/<\/?strong\s*\/?>/gi, "");
                    return html
                }
            }

            Label {
                font.pixelSize: Theme.fontSizeExtraSmall
                text: Qt.formatDateTime(new Date(model.pubDate), "dd MMMM yyyy")
                color: Theme.secondaryHighlightColor
            }
        }
    }
}
