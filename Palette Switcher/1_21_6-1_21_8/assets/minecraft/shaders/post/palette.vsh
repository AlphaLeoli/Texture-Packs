#version 150

uniform sampler2D PaletteSampler;

in vec3 Position;

out vec2 texCoord;

#moj_import <minecraft:config.glsl>
#moj_import <minecraft:code/palette_switcher_vsh.glsl>

void main() {
    vec2 screenPos = Position.xy * 2.0 - 1.0;
    gl_Position = vec4(screenPos.x, screenPos.y, 1.0, 1.0);
    texCoord = Position.xy;

    sortPalette();
}
