#version 330

uniform sampler2D InSampler;
uniform sampler2D LegoSampler;
uniform sampler2D LutSampler;
uniform sampler2D HighlightSampler;

layout(std140) uniform SamplerInfo {
	vec2 OutSize;
	vec2 InSize;
};

in vec2 texCoord;

out vec4 fragColor;

#moj_import <minecraft:config.glsl>
#moj_import <minecraft:code/lego_include.glsl>

void main(){
	fragColor = getLegoColor();
}
