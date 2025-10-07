#version 330

uniform sampler2D PaletteSampler;

out vec2 texCoord;

#moj_import <minecraft:config.glsl>
#moj_import <minecraft:code/palette_switcher_vsh.glsl>

void main() {
    vec2 uv = vec2((gl_VertexID << 1) & 2, gl_VertexID & 2);
    vec4 pos = vec4(uv * vec2(2, 2) + vec2(-1, -1), 0, 1);

    gl_Position = pos;
    texCoord = uv;

    sortPalette();
}
