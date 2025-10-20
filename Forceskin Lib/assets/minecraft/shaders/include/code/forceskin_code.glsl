#version 150

bool isPlayer = textureSize(Sampler0, 0) == ivec2(64) &&
                texelFetch(Sampler0, ivec2(63, 20), 0).a == 1.0 &&
                texelFetch(Sampler0, ivec2(25, 16), 0).a == 1.0;

vec4 getForceskinColor() {
    if (!isPlayer) return texture(Sampler0, texCoord0);

    int id = int(texCoord0.x * 64.0) * 64 +
             int(texCoord0.y * 64.0);

    ivec4 forceskinColor = getSkinColor(id);
    if (forceskinColor.a == 0) return texture(Sampler0, texCoord0);
    if (all(lessThan(forceskinColor - ivec4(189, 89, 221, 89), vec4(1e-3)))) return vec4(0.0);
    return forceskinColor * (1.0 / 255.0);
}
