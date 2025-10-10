#version 330

vec4 getEspColor() {
    return texture(InSampler, texCoord) * 0.75;
}