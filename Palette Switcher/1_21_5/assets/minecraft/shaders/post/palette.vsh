#version 150

uniform sampler2D PaletteSampler;

in vec4 Position;

uniform mat4 ProjMat;
uniform vec2 OutSize;

out vec2 texCoord;

#moj_import <minecraft:config.glsl>
#moj_import <minecraft:code/palette_switcher_vsh.glsl>

void main() {
    vec4 outPos = ProjMat * vec4(Position.xy * OutSize, 0.0, 1.0);
    gl_Position = vec4(outPos.xy, 0.2, 1.0);

    texCoord = Position.xy;

    sortPalette();
}
