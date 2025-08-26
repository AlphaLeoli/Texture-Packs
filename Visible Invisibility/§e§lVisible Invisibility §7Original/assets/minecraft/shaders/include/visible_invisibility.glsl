#version 150

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

const float Tolerance = 5e-3;
const float ColorTolerance = 1e-5;

vec4 getParticleColor() {
    float yCoord = fract(texCoord0.y * atlasSize);
    vec4 tintColor = particleTint;
    vec4 textureColor = texture(Sampler0, texCoord0);
    float oldAlpha = textureColor.a;

    bool isTransparentPotionParticle =
        textureColor.rgb == vec3(0.0) &&
        abs(oldAlpha - 0.25) < Tolerance;
    bool isSolidPotionParticle =
        abs(oldAlpha - 0.75) < Tolerance;

    if (isSolidPotionParticle || isTransparentPotionParticle) { // if its a potion particle
        yCoord *= 0.5;
        if (round(tintColor.rgb * 1000000) == vec3(964706)) { // if its an invisibility particle
            tintColor = vec4(1.0);
            yCoord += 0.5;
        }
        float id = floor(texCoord0.y * atlasSize);
        float minY = id * atlasTileSize;
        float maxY = minY + atlasTileSize;
        yCoord = mix(minY, maxY, yCoord);
        textureColor = texture(Sampler0, vec2(texCoord0.x, yCoord));
        float newAlpha = textureColor.a;
        if (max(max(textureColor.r, textureColor.g), textureColor.b) < Tolerance &&
            newAlpha > 0.245 &&
            newAlpha < 0.255
        ) discard;
        textureColor.a = 1.0;
    }

    vec4 color = textureColor * lightColor * tintColor * ColorModulator;
    if (textureColor.a < 0.1) discard;
    return color;
}