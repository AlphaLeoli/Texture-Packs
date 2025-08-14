#version 150

#moj_import <minecraft:config.glsl>

uniform sampler2D InSampler;
uniform sampler2D AsciiSampler;
uniform sampler2D MinecraftSampler;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
};

in vec2 texCoord;

out vec4 fragColor;

#moj_import <minecraft:code/text_renderer_ascii.glsl>

void main() {
    fragColor = getAsciiColor();
}