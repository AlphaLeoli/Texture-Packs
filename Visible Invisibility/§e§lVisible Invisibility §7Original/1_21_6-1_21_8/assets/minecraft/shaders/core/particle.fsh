#version 150

#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:dynamictransforms.glsl>

uniform sampler2D Sampler0;

in float sphericalVertexDistance;
in float cylindricalVertexDistance;
in vec2 texCoord0;

in vec4 lightColor;
in vec4 particleTint;

out vec4 fragColor;

#moj_import <minecraft:visible_invisibility.glsl>

void main() {
    fragColor = apply_fog(getParticleColor(), sphericalVertexDistance, cylindricalVertexDistance, FogEnvironmentalStart, FogEnvironmentalEnd, FogRenderDistanceStart, FogRenderDistanceEnd, FogColor);
}
