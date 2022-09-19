import QtQuick.Window 2.12
import QtQuick 2.12
import QtCharts 2.3
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.12

Window {
    id: mainWindow

    width: 720
    height: 720
    maximumWidth: 720
    maximumHeight: 720
    minimumWidth: 720
    minimumHeight: 720
    visible: true
    title: qsTr("Graph")

    property real margin: 0.085 * width
    property color blueColor: Qt.rgba(0.36, 0.61, 0.83)
    property color grayColor: "gray"

    ChartView {
        id: scatter

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        margins.right: 0.5 * mainWindow.margin

        height: 0.75 * parent.height
        antialiasing: true
        legend.visible: true

        ScatterSeries {
            id: scatterSeries
            name: "Scatter Series"

            color: mainWindow.blueColor
            axisX: ValueAxis {
                min: 0.0
                max: graphController.range
                tickCount: 2
                labelsVisible: false
                color: mainWindow.grayColor
            }
            axisY: ValueAxis {
                min: 0.0
                max: graphController.range
                tickCount: 2
                labelsVisible: false
                color: mainWindow.grayColor
            }
//            XYPoint {
//                x: 5
//                y: 5
//            }
        }

//        // @disable-check M16
//        Component.onCompleted: {
//            for (var i = 0; i <= 5; i++) {
//                scatterSeries.append(i, Math.random());
//            }
//        }

        Connections {
            target: graphController

            onProgressChanged: {
                point.forEach(function(item, i, arr) {          // call function for each array item
                        scatterSeries.append(item.x, item.y)
                    });
            }
        }
    }

    Row {
        id: buttonRow

        anchors {
            top: scatter.bottom
            left: parent.left
            right: parent.right
            leftMargin: mainWindow.margin
            rightMargin: mainWindow.margin
            bottomMargin: mainWindow.margin
        }

        property real buttonSize: mainWindow.height - scatter.height - mainWindow.margin
        property real buttonPadding: 15
        spacing: (mainWindow.width - mainWindow.margin * 2 - buttonSize * 3) / 2

        Button {
            width: parent.buttonSize
            height: parent.buttonSize
            padding: parent.buttonPadding

            contentItem: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height

                Canvas{
                    anchors.fill: parent

                    onPaint: {
                        var context = getContext("2d");
                        // the triangle
                        context.beginPath();
                        context.moveTo(0, 0);
                        context.lineTo(0, buttonRow.buttonSize - buttonRow.buttonPadding * 2);
                        context.lineTo(buttonRow.buttonSize - buttonRow.buttonPadding * 2 - 2,
                                       (buttonRow.buttonSize - buttonRow.buttonPadding * 2) / 2);
                        context.closePath();
                        // the fill color
                        context.fillStyle = mainWindow.blueColor;
                        context.fill();
                    }
                }
            }

            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                opacity: enabled ? 1 : 0.3
                color: parent.down ? "#d0d0d0" : "#FFFFFF"
                border {
                    color: mainWindow.grayColor
                    width: 3
                }
            }

            onClicked: {
                graphController.startButtonClicked();
            }
        }

        Button {
            width: parent.buttonSize
            height: parent.buttonSize
            padding: parent.buttonPadding

            contentItem: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height

                Canvas{
                    anchors.fill: parent

                    onPaint: {
                        var context = getContext("2d");
                        var canvasSize = buttonRow.buttonSize - buttonRow.buttonPadding * 2

                        context.beginPath();
                        context.moveTo(0, 0);
                        context.lineTo(0, canvasSize);
                        context.lineTo(canvasSize / 3, canvasSize);
                        context.lineTo(canvasSize / 3, 0);

                        context.moveTo(canvasSize - canvasSize / 3 - 3, 0);
                        context.lineTo(canvasSize  - canvasSize / 3 - 3, canvasSize);
                        context.lineTo(canvasSize, canvasSize);
                        context.lineTo(canvasSize, 0);
                        context.closePath();

                        context.fillStyle = mainWindow.blueColor;
                        context.fill();
                    }
                }
            }

            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                opacity: enabled ? 1 : 0.3
                color: parent.down ? "#d0d0d0" : "#FFFFFF"
                border {
                    color: mainWindow.grayColor
                    width: 3
                }
            }

            onClicked: {
                graphController.pauseButtonClicked();
            }
        }

        Button {
            width: parent.buttonSize
            height: parent.buttonSize
            padding: parent.buttonPadding

            contentItem: Rectangle {
                implicitWidth: parent.width - buttonRow.buttonPadding
                implicitHeight: parent.height - buttonRow.buttonPadding
                color: mainWindow.blueColor
            }

            background: Rectangle {
                implicitWidth: parent.width
                implicitHeight: parent.height
                opacity: enabled ? 1 : 0.3
                color: parent.down ? "#d0d0d0" : "#FFFFFF"
                border {
                    color: mainWindow.grayColor
                    width: 3
                }
            }

            onClicked: {
                graphController.stopButtonClicked();
                scatter.removeAllSeries();
            }
        }
    }
}
