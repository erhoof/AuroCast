/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

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
    //width: parent ? parent.width : undefined
    height: 280

    //anchors.fill: parent

    ColumnLayout {
        //spacing: Theme.paddingMedium
        //width: parent.width
        anchors.fill: parent
        anchors.margins: Theme.paddingMedium

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true

            spacing: Theme.paddingMedium
            anchors.margins: Theme.paddingMedium

            Image {
                //Layout.minimumWidth: parent.height
                //Layout.preferredWidth: parent.height
                //Layout.maximumWidth: parent.height
                //Layout.minimumHeight: parent.height
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft
                Layout.preferredWidth: Theme.iconSizeLarge
                Layout.preferredHeight: Theme.iconSizeLarge

                fillMode: Image.PreserveAspectCrop

                source: model.cover
            }

            Label {
                Layout.fillWidth: true
                //Layout.fillHeight: true
                Layout.alignment: Qt.AlignTop | Qt.AlignLeft

                color: Theme.primaryColor
                font.pixelSize: Theme.fontSizeSmall
                maximumLineCount: 4
                wrapMode: Text.Wrap
                elide: Text.ElideMiddle

                text: model.title
            }
        }

        Label {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.alignment: Qt.AlignBottom | Qt.AlignLeft

            //width: parent.width
            color: Theme.secondaryColor
            wrapMode: Text.WordWrap
            elide: Text.ElideRight
            font.pixelSize: Theme.fontSizeTiny
            maximumLineCount: 4

            text: model.description
        }

        /*Label {
            Layout.preferredHeight: Theme.iconSizeLarge

            //Layout.fillWidth: true
            //Layout.fillHeight: true

            color: Theme.secondaryColor
            //wrapMode: Text.WordWrap
            //truncationMode: TruncationMode.Elide
            font.pixelSize: Theme.fontSizeTiny
            maximumLineCount: 4

            text: model.description
        }*/
    }
}
