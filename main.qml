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
//        margins {
//            top: mainWindow.margin
//            bottom: mainWindow.margin
//            left: mainWindow.margin
//            right: mainWindow.margin
//        }
//        backgroundColor: "lightgreen"

        height: 0.75 * parent.height
        antialiasing: true
        legend.visible: false
//        title: qsTr("scatter")

//        axes: ValuesAxis {
//            gridVisible: false
//        }

//        x: 170
//        y: 90
//        width: 300
//        height: 300

        ScatterSeries {
            name: "ScatterSeries"
            id: scatterSeries

            color: mainWindow.blueColor
            axisX: ValueAxis {
                min: 0.0
                max: 10
                tickCount: 2
                labelsVisible: false
                color: mainWindow.grayColor
            }
            axisY: ValueAxis {
                min: 0.0
                max: 10
                tickCount: 2
                labelsVisible: false
                color: mainWindow.grayColor
            }

            XYPoint {
                x: 1
                y: 1
            }

            XYPoint {
                x: 2
                y: 4
            }

            XYPoint {
                x: 4
                y: 2
            }

            XYPoint {
                x: 5
                y: 5
            }
        }

        onSeriesAdded: {
//            zoomOut();
        }
        // @disable-check M16
        Component.onCompleted: {
            console.log("Component.onCompleted!!!!!!!!!!!!!" + axisX());
            scatterSeries.append(10, 10);
            scatterSeries.append(3, 3);
            for (var i = 0; i <= 10; i++) {
                scatterSeries.append(i, Math.random());
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
        }
    }
}
