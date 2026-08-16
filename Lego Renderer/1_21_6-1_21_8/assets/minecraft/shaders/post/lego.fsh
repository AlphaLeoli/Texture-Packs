#version 150

uniform sampler2D InSampler;

layout(std140) uniform SamplerInfo {
	vec2 OutSize;
	vec2 InSize;
};

in vec2 texCoord;

out vec4 fragColor;

void main(){
	fragColor = getMosaicColor();
}
