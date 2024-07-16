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
