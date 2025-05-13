/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.me>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import QtQuick.Layouts 1.1
import Sailfish.Silica 1.0
import Aurora.Controls 1.0

import "../model"
import "../pages"
import ".."

/**
 * General StationsListView spans as much space as it could get with `Layout.fill{Height,Width}`
 * and uses `StationListElement` as its `delegate`, while leaving `model` undefined.
 *
 * A `model` must be a sub-component of StationsListModel.
 *
 * Check `StationListElement`'s documentation for the delegate's expectactions about the model.
 */
ListView {
    id: view

    spacing: Theme.paddingLarge

    Component {
        id: stationPage
        StationPage {}
    }

    VerticalScrollDecorator {
        anchors.rightMargin: -Theme.horizontalPageMargin
    }

    delegate: StationListElement {
        onClicked: {
            var page = stationPage.createObject(view, {
                station: view.model.stationAt(index)
            });
            pageStack.push(page);
        }
    }
}
