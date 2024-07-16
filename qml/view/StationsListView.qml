/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

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
SilicaListView {
    id: view

    Layout.fillHeight: true
    Layout.fillWidth: true

    Component {
        id: stationPage
        StationPage {}
    }

    delegate: StationListElement {
        onClicked: {
            var page = stationPage.createObject(view, {
                station: view.model.stationAt(index)
            });
            //splitView.pop(Qt.resolvedUrl("EmptyPage.qml"), SplitView.Immediate)
            //splitView.pop(Qt.resolvedUrl("StationPage.qml"), SplitView.Immediate)
            //splitView.pop(SplitView.Immediate)
            //splitView.pop();
            //splitView.scrollFirstActiveItemBack(1)
            splitView.push(page)
        }
    }
    VerticalScrollDecorator {}
}
