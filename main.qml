import QtQuick 2.6
import QtQuick.Window 2.2

Window {
    visible: true
    width: 640
    height: 480

    property real angle: 0.0
    property real rad: Math.PI * angle / 180.0

    NumberAnimation on angle {
        from: 0; to: 360
        running: true
        loops: Animation.Infinite
        duration: 2000
    }

    ShaderEffect {
        width: 200
        height: 200
        anchors.centerIn: parent

        property real animated_color: Math.sin(rad) * 0.5 + 0.5

        vertexShader: "
            uniform highp mat4 qt_Matrix;
            attribute highp vec4 qt_Vertex;
            attribute highp vec2 qt_MultiTexCoord0;
            varying highp vec2 coord;
            void main() {
                coord = qt_MultiTexCoord0;
                gl_Position = qt_Matrix * qt_Vertex;
            }"

        fragmentShader: "
            varying highp vec2 coord;
            uniform highp float animated_color;

            uniform lowp float qt_Opacity;
            void main() {

                gl_FragColor = vec4(coord.x, coord.y, animated_color, 1) * qt_Opacity;
            }"
    }
}
