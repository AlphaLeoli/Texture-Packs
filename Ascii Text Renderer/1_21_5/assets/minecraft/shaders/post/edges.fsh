#version 150

uniform sampler2D MainDepthSampler;

uniform mat4 ProjMat;

uniform vec2 OutSize;

in vec2 texCoord;

out vec4 fragColor;

#moj_import <minecraft:code/text_renderer_edges.glsl>

void main() {
    fragColor = getEdgeColor();
}
