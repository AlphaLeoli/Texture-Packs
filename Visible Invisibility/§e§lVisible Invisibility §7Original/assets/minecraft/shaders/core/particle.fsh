#version 150

#moj_import <minecraft:fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0) * ColorModulator;
    // 0.9647058823529412 invis vertexColor
    // 127.5 == black
    // 191.25 == transparent
    // 63.75 == yellow
    if (round(vertexColor.rgb * 1000000) == vec3(964706)) {
        float alpha = round(color.a * 100.0);
        if (alpha > 60.0) {
            discard;
        }
        if (alpha == 25.0) {
            color.rgb = vec3(1.0, 1.0, 0.34);
        }
        if (alpha == 50.0) {
            color.rgb = vec3(0.0);
        }
    } else {
        if (color.rgb == vec3(1.0, 0.0, 0.0)) {
            discard;
        } else {
            color *= vertexColor;
        }
    }
    if (color.a < 0.1) {
        discard;
    } else {
        color.a = 1.0;
    }

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
