#version 150

uniform sampler2D InSampler;

uniform vec2 OutSize;

in vec2 texCoord;

out vec4 fragColor;

#moj_import <minecraft:code/text_renderer_sobel.glsl>

void main() {
    fragColor = getSobelColor();
}
