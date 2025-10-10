#version 330

uniform sampler2D InSampler;

in vec2 texCoord;

out vec4 fragColor;

#moj_import <minecraft:code/esp_include.glsl>

void main(){
    fragColor = getEspColor();
}