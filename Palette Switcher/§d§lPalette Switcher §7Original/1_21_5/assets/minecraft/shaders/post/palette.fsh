#version 150

uniform sampler2D InSampler;
uniform sampler2D DitherSampler;
uniform sampler2D PaletteSampler;

uniform vec2 OutSize;

in vec2 texCoord;
out vec4 fragColor;

#moj_import <minecraft:config.glsl>
#moj_import <minecraft:code/palette_switcher_fsh.glsl>

void main() {
    fragColor = getPaletteColor();
}
