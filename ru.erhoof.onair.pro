
TARGET = ru.erhoof.onair

CONFIG += \
    c++14 \
    auroraapp

SOURCES += src/main.cpp

# to disable building translations every time, comment out the following CONFIG line
CONFIG += auroraapp_i18n

TRANSLATIONS += \
    translations/ru.erhoof.onair.ts \
    translations/ru.erhoof.onair-ru.ts \

DISTFILES += \
    icons/108x108/ru.erhoof.onair.png \
    icons/128x128/ru.erhoof.onair.png \
    icons/172x172/ru.erhoof.onair.png \
    icons/256x256/ru.erhoof.onair.png \
    icons/86x86/ru.erhoof.onair.png \
    meta/database.md \
    meta/schema.sql \
    qml/model/Episode.qml \
    qml/model/EpisodesListModel.qml \
    qml/model/SearchResult.qml \
    qml/model/Station.qml \
    qml/model/StationsListModel.qml \
    qml/model/SubscriptionsListModel.qml \
    qml/pages/EmptyPage.qml \
    qml/pages/PlayerPage.qml \
    qml/pages/SearchPage.qml \
    qml/pages/StationPage.qml \
    qml/pages/SubscriptionsPage.qml \
    qml/service/Dao.qml \
    qml/service/ITunes.qml \
    qml/service/qmldir \
    qml/view/CoverView.qml \
    qml/view/EpisodeListElement.qml \
    qml/view/EpisodesListView.qml \
    qml/view/StationHeader.qml \
    qml/view/StationListElement.qml \
    qml/view/StationsListView.qml \
    qml/ru.erhoof.onair.qml \
    rpm/ru.erhoof.onair.spec \
    rpm/ru.erhoof.onair.yaml

AURORAAPP_ICONS = 86x86 108x108 128x128 172x172
