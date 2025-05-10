/*
  SPDX-FileCopyrightText: 2017, 2022 ivan tkachenko <me@ratijas.tk>

  SPDX-License-Identifier: MIT OR Apache-2.0
*/

import QtQuick 2.0
import "../service"

StationsListModel {
    function refresh() {
        Dao.subscriptions(this, function(subscriptions) {
            setStations(subscriptions);
        });
    }

    function refresh_impl(feed_url, subscribed) {
        refresh();
    }

    Component.onCompleted: {
        Dao.subscription.connect(refresh_impl);
        refresh();
    }
}
