#version 150

#moj_import <minecraft:projection.glsl>

uniform sampler2D MainDepthSampler;

layout(std140) uniform SamplerInfo {
    vec2 OutSize;
    vec2 InSize;
};

in vec2 texCoord;

out vec4 fragColor;

#moj_import <minecraft:code/papercraft_edges.glsl>

void main(){
    fragColor = getEdgeColor();
}
