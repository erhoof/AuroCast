/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>
  SPDX-FileCopyrightText: 2023-2025 Pavel Bibichenko <b7086163@gmail.com>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import Sailfish.Silica 1.0
import QtGraphicalEffects 1.0

Item {
    id: view

    property url cover
    property alias status: coverImage.status
    property bool highlighted: false

    states: [
        State {
            name: "error"
            when: view.status === Image.Error
            PropertyChanges {
                target: coverImage
                opacity: 0
            }
            PropertyChanges {
                target: coverDefault
                opacity: 1
            }
        }
    ]

    transitions: [
        Transition {
            to: "loading"

            NumberAnimation {
                target: coverImage
                property: "opacity"
                duration: 0
            }
        },
        Transition {
            NumberAnimation {
                targets: [coverImage, coverDefault]
                property: "opacity"
                duration: 2000
                easing.type: Easing.InOutQuad
            }
        }
    ]

    Image {
        id: coverImage

        fillMode: {
            var max = Math.max(sourceSize.height, sourceSize.width);
            var min = Math.min(sourceSize.height, sourceSize.width);

            return ((max - min) / min) < 0.1
                    ? Image.PreserveAspectCrop
                    : Image.PreserveAspectFit;
        }
        anchors.fill: view

        source: view.cover

        opacity: 1

        layer.enabled: true
        layer.effect: OpacityMask {
            maskSource: Rectangle {
                width: coverImage.width
                height: coverImage.height
                radius: 10
            }
        }
    }

    BusyIndicator {
        anchors.centerIn: view

        size: Math.min(view.height, view.width) <= Theme.iconSizeLarge
                ? BusyIndicatorSize.Medium :
                  BusyIndicatorSize.Large
        running: (view.cover.toString() !== "") && (status !== Image.Error) && (status !== Image.Ready)
    }
}
