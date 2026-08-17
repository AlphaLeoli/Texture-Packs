#version 150

uniform sampler2D InSampler;
uniform sampler2D LegoSampler;
uniform sampler2D LutSampler;
uniform sampler2D HighlightSampler;

uniform vec2 OutSize;

in vec2 texCoord;

out vec4 fragColor;

#moj_import <minecraft:config.glsl>
#moj_import <minecraft:code/lego_include.glsl>

void main(){
	fragColor = getLegoColor();
}
