#version 330

/* Methods for detecting if its a potion particle:

- if the tint color isn't another particle's tint color (this was a bad idea..)
- if there is a pixel at a certain location with a certain color/alpha (metadata essentially)
- if every pixel is a certain transparency (what im doing rn)

dm me if you find another solution.. my discord is alphaleoli
*/

// 0.9647058823529412 invis vertexColor
// 127.5 == 0.75
// 191.25 == 0.5
// 63.75 == 0.25

float atlasSize = textureSize(Sampler0, 0).y * 0.0625;
float atlasTileSize = 1.0 / atlasSize;

const float AlphaTolerance = 5e-3;
bool isAlphaClose(float alpha, float target) {
    return abs(alpha - target) < AlphaTolerance;
}

const vec4 ColorTolerance = vec4(vec3(5e-3), AlphaTolerance);
bool isColorClose(vec4 color, vec4 target) {
    return all(lessThan(abs(color - target), ColorTolerance));
}

vec4 getParticleColor() {
    float yCoord = fract(texCoord0.y * atlasSize);
    vec4 tintColor = particleTint;
    vec4 textureColor = texture(Sampler0, texCoord0);

    bool isTransparentPotionParticle =
        isColorClose(textureColor, vec4(vec3(0.0), 0.25));
    bool isSolidPotionParticle =
        isAlphaClose(textureColor.a, 0.75);

    // If its a potion particle
    if (isSolidPotionParticle || isTransparentPotionParticle) {
        yCoord *= 0.5;

        // If its an invisibility particle
        if (isColorClose(tintColor, vec4(vec3(0.964706), 1.0))) {
            tintColor = vec4(1.0);
            yCoord += 0.5;
        }

        // Remap the Y coordinate
        float minY = floor(texCoord0.y * atlasSize) * atlasTileSize;
        float maxY = minY + atlasTileSize;
        yCoord = mix(minY, maxY, yCoord);

        // Set the correct color
        textureColor = texture(Sampler0, vec2(texCoord0.x, yCoord));
        if (isColorClose(textureColor, vec4(vec3(0.0), 0.25))) discard;
        textureColor.a = 1.0;
    }

    vec4 color = textureColor * lightColor * tintColor * ColorModulator;
    if (textureColor.a < 0.1) discard;
    return color;
}