#version 150

const float squareSize = 64.0;
const float squareTileSize = 1.0 / squareSize;

vec2 atlasSize = textureSize(Sampler0, 0) / 16;
vec2 atlasTileSize = 1.0 / atlasSize;

vec4 getChowderColor() {
    vec2 uv = mod(gl_FragCoord.xy, squareSize) * squareTileSize;
    uv.y = 1.0 - uv.y;

    // Map the new uv value based on the texture atlas
    vec2 tileID = floor(texCoord0 * atlasSize);
    vec2 uvMin = tileID * atlasTileSize;
    vec2 uvMax = uvMin + atlasTileSize;
    vec2 mappedUV = mix(uvMin, uvMax, uv);

    return textureLod(Sampler0, mappedUV, 0.0) * vertexColor * ColorModulator;
}