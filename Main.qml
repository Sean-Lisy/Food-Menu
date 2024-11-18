import QtQml 2.9
import QtQuick 2.9
import QtQuick.Controls 2.9

pragma ComponentBehavior: Bound

Window {
    visible: true
    title: "Food Menu"
    color: "#fafafa"

    property real dynamicFontSize: Screen.pixelDensity > 1? 16 : 14
    property real borderRadius: Screen.pixelDensity > 1? 10 : 8
    property real buttonWidth: Screen.pixelDensity > 1? 100 : 80
    property real buttonHeight: Screen.pixelDensity > 1? 45 : 40
    property real controlSpacing: Screen.pixelDensity > 1? 25 : 20
    width: Screen.width  //1240 Screen.width
    height:  Screen.height //2770 Screen.height

    // 根据平台选择分辨率
    Component.onCompleted : {
        if (Qt.platform.os === "android") {
            console.log("Running on Android.");
            width = Screen.width;
            height = Screen.height

        } else if(Qt.platform.os === "windows") {
            console.log("Running on Windows.");
            width = 1240 / 2;
            height = 2770 / 2
        }
    }

    // 背景渐变
    Rectangle {
        visible: true
        anchors.fill: parent
        anchors.leftMargin: 0
        anchors.rightMargin: 0
        anchors.topMargin: 0
        anchors.bottomMargin: 0
        gradient: Gradient {
            // orientation: Gradient.Vertical
            GradientStop {
                position: 0
                color: "#4158d0"
            }
            GradientStop {
                position: 1
                color: "#c850c0"
            }
        }
        // 菜单输入框
        TextField
        {
            id : enter_menu
            x : parent.x + parent.width * 0.05
            y : parent.y + parent.height / 20
            width : parent.width * 0.9
            height : parent.height / 15
            leftPadding: enter_image.width * 2
            font.pixelSize : 16
            placeholderText: qsTr("      请输入你的菜单...")
            placeholderTextColor: "#999999"//提示词背景颜色
            background: Rectangle {
                radius: height / 2.5
                color : "#e6e6e6"
            }
            verticalAlignment: Text.AlignVCenter
        }
        Image
        {
            id : enter_image
            width : height
            height : enter_menu.height / 3 * 2
            x : enter_menu.x + height / 6
            y : enter_menu.y + height / 6
            source: "qrc:/new/prefix1/qrc/enter.png"
        }

        Text {
            id : text1
            x : enter_menu.x + slider_handle.width / 2
            y: row_slider.y + row_slider.y / 3 * 2
            horizontalAlignment: Text.AlignLeft
            font.pixelSize : 14
            color : "#999999"
            text : qsTr("1")
        }
        Text {
            x : text1.x + (row_slider.width - slider_handle.width) / 4
            y: text1.y
            horizontalAlignment: Text.AlignLeft
            font.pixelSize : 14
            color : "#999999"
            text : qsTr("2")
        }
        Text {
            x : text1.x + (row_slider.width - slider_handle.width) / 4 * 2
            y: text1.y
            horizontalAlignment: Text.AlignLeft
            font.pixelSize : 14
            color : "#999999"
            text : qsTr("3")
        }
        Text {
            x : text1.x + (row_slider.width - slider_handle.width) / 4 * 3
            y: text1.y
            horizontalAlignment: Text.AlignLeft
            font.pixelSize : 14
            color : "#999999"
            text : qsTr("4")
        }
        Text {
            x : text1.x + (row_slider.width - slider_handle.width) / 4 * 4
            y: text1.y
            horizontalAlignment: Text.AlignLeft
            font.pixelSize : 14
            color : "#999999"
            text : qsTr("5")
        }

        Row {
            id : row_slider
            x : enter_menu.x
            y: enter_menu.y + parent.height / 10
            z : 1
            width: enter_menu.width
            height : enter_menu.height

            Slider {
                id: slider
                value: 1
                stepSize: 1
                from: 1
                to: 5
                leftPadding : 0
                rightPadding : leftPadding
                height: parent.height
                width: parent.width
                orientation : Qt.Horizontal
                snapMode : Slider.SnapOnRelease
                live : false

                onPressedChanged: {
                    if( pressed ) {
                        console.log("pressed")
                    }else {
                        console.log("released")
                        var nValue = slider.value;
                        if (slider.pressed) {
                            return;
                        }
                        if (nValue == 1) {
                            image_slide.source = "qrc:/new/prefix1/qrc/sad.png";
                        } else if (nValue == 2) {
                            image_slide.source = "qrc:/new/prefix1/qrc/creepy.png";
                        } else if (nValue == 3) {
                            image_slide.source = "qrc:/new/prefix1/qrc/confused-3.png";
                        } else if (nValue == 4) {
                            image_slide.source = "qrc:/new/prefix1/qrc/happy-11.png";
                        } else if (nValue == 5) {
                            image_slide.source = "qrc:/new/prefix1/qrc/in-love-2.png";
                        }
                        foodMenu.fillMenuMap(enter_menu.text, nValue);
                    }
                }

                background: Rectangle {
                    radius: height / 2.5
                    opacity : 1
                    color: "#e6e6e6"
                    Rectangle {
                        width: slider.visualPosition * parent.width
                        height: parent.height
                        color: "#21be2b"
                        radius: height / 2.5
                    }
                }

                handle: Rectangle {
                    id : slider_handle
                    x: slider.leftPadding + slider.visualPosition * (slider.availableWidth - width)
                    y: slider.topPadding + slider.availableHeight / 2 - height / 2
                    width: height
                    height: slider.height
                    radius: height / 2
                    border.color: "#FBD971"
                    Image {
                        id : image_slide
                        width: height
                        height: parent.height
                        source:  "qrc:/new/prefix1/qrc/happy-11.png"
                    }
                }
            }
        }

        // TextArea + ScrollView
        Rectangle {
            x : enter_menu.x
            y : row_slider.y + row_slider.y / 3 * 3
            width : enter_menu.width
            height : parent.height / 2
            // visible: true
            ScrollView {
                id : scrollViem
                anchors.fill : parent;
                TextArea {
                    id: textArea
                    visible: true
                    font.pixelSize : 15
                    // color : "yellow"
                    wrapMode: TextArea.Wrap
                    background : Rectangle {
                        color : "#e6e6e6"
                        Image {
                            width : parent.width
                            height : parent.height
                            // source: "qrc:/new/prefix1/qrc/background.png"
                        }
                    }
                }
            }
        }

        // Button Show Menu Score And Date
        Button {
            id : btnShow
            x : enter_menu.x
            y : row_slider.y + row_slider.y / 3 * 4 + parent.height / 2
            width : enter_menu.width * 0.45
            height : enter_menu.height
            background : Rectangle {
                visible : true
                id : btnBackground
                implicitHeight:btnShow.height
                implicitWidth:btnShow.width
                anchors.fill : parent;
                opacity: enabled ? 1 : 0.3
                color : "#e6e6e6"
                radius : btnShow.height / 2

                Row {
                    leftPadding : topPadding
                    topPadding : height * 0.15
                    height: parent.height
                    width : parent.width
                    Image {
                        width : btnShow.height * 0.7
                        height: width
                        horizontalAlignment: Image.AlignLeft
                        verticalAlignment: Image.AlignVCenter
                        source: "qrc:/new/prefix1/qrc/look1.png"
                    }
                    Text {
                        x : btnShow.height
                        width : parent.width - btnShowImage.width
                        wrapMode: Text.WordWrap
                        height : btnShow.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.pixelSize : 16
                        text : qsTr("评分清单")
                    }
                }
            }
            onPressed : {
                var strData;
                strData = foodMenu.getHistoryMenu();
                console.log(strData);
                textArea.text = strData;
            }
        }

        Button {
            id: btnAnalyze
            font.pointSize: 16 // 设置字体大小
            visible : true
            x : enter_menu.x + enter_menu.width - width
            y : btnShow.y
            width : btnShow.width
            height : btnShow.height

            // visible : true
            background : Rectangle {
                visible : true
                implicitHeight:btnShow.height
                implicitWidth:btnShow.width
                anchors.fill : parent;
                opacity: enabled ? 1 : 0.3
                color : "#e6e6e6"
                radius : btnShow.height / 2

                Row {
                    leftPadding : 0
                    height: parent.height
                    width : parent.width
                    Image {
                        width : btnShow.height
                        height : width
                        horizontalAlignment: Image.AlignLeft
                        source: "qrc:/new/prefix1/qrc/look.png"
                    }
                    Text {
                        x : btnShow.height
                        width : parent.width - btnShowImage.width
                        wrapMode: Text.WordWrap
                        height : btnShow.height
                        verticalAlignment: Text.AlignVCenter
                        horizontalAlignment: Text.AlignLeft
                        font.pixelSize : 16
                        text : qsTr("菜单分析")
                    }
                }
            }
        }
    }
}
