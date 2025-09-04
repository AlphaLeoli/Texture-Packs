#version 150

#moj_import <minecraft:fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec2 texCoord0;

in vec4 lightColor;
in vec4 particleTint;

out vec4 fragColor;

#moj_import <minecraft:particle_effects.glsl>

void main() {
    fragColor = linear_fog(getParticleColor(), vertexDistance, FogStart, FogEnd, FogColor);
}
