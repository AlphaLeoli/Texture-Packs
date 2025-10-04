#version 150

#moj_import <minecraft:config.glsl>

uniform sampler2D InSampler;
uniform sampler2D OutlinesSampler;
uniform sampler2D PaperSampler;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
};

in vec2 texCoord;

out vec4 fragColor;

#moj_import <minecraft:code/papercraft_paper.glsl>

void main(){
    fragColor = getFinalColor();
}
