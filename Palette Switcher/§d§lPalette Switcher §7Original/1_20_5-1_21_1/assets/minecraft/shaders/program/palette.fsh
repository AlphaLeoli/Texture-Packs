#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D DitherSampler;
uniform sampler2D PaletteSampler;

uniform vec2 OutSize;

in vec2 texCoord;

out vec4 fragColor;

#define InSampler DiffuseSampler
#moj_import <config.glsl>
#moj_import <code/palette_switcher_fsh.glsl>

void main(){
    fragColor = getPaletteColor();
}
