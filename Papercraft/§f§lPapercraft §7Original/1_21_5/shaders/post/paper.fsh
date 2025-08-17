#version 150

#moj_import <minecraft:config.glsl>

uniform sampler2D InSampler;
uniform sampler2D OutlinesSampler;
uniform sampler2D PaperSampler;

uniform vec2 OutSize;

in vec2 texCoord;

out vec4 fragColor;

#moj_import <minecraft:code/papercraft_paper.glsl>

void main(){
    fragColor = getFinalColor();
}
