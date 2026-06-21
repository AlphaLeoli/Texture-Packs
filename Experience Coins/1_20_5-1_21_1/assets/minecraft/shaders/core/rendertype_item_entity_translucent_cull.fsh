#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec4 lightMapColor;
in vec4 tintColor;

out vec4 fragColor;

void main() {
    #moj_import <code/animate_texture.glsl>
    vec4 color = texture(Sampler0, newCoord) * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    #moj_import <code/fix_colors.glsl>
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}