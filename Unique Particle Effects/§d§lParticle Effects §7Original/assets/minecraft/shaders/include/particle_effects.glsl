#version 150

const ivec4 potionParticleIdentifier = ivec4(55, 117, 120, 97);

int scaleRGB(float value) {
    return int(value * 255.0 + 0.5);
}

int rgbToHex(vec3 color) {
    int r = scaleRGB(color.r);
    int g = scaleRGB(color.g);
    int b = scaleRGB(color.b);
    return (r << 16) | (g << 8) | b;
}

// https://minecraft.wiki/w/Effect_colors
// https://minecraft.wiki/w/Effect_colors/Java_Edition_potion_color_changes_in_1.19.4
ivec2 getPotionCoordOffset(vec3 color) {
    switch (rgbToHex(color)) {
        case 0x33EBFF: return ivec2(1, 0); // Speed
        case 0x8BAFE0: return ivec2(2, 0); // Slowness
        case 0xD9C043: return ivec2(3, 0); // Haste
        case 0x4A4217: return ivec2(4, 0); // Mining Fatigue
        case 0xFFC700: return ivec2(5, 0); // Strength
        case 0xF82423: return ivec2(6, 0); // Instant Health
        case 0xA9656A: return ivec2(7, 0); // Instant Damage
        case 0xFDFF84: return ivec2(0, 1); // Jump Boost
        case 0x551D4A: return ivec2(1, 1); // Nausea
        case 0xCD5CAB: return ivec2(2, 1); // Regeneration
        case 0x9146F0: return ivec2(3, 1); // Resistance
        case 0xFF9900: return ivec2(4, 1); // Fire Resistance
        case 0x98DAC0: return ivec2(5, 1); // Water Breathing
        case 0xF6F6F6: return ivec2(6, 1); // Invisibility
        case 0x1F1F23: return ivec2(7, 1); // Blindness
        case 0xC2FF66: return ivec2(0, 2); // Night Vision
        case 0x587653: return ivec2(1, 2); // Hunger
        case 0x484D48: return ivec2(2, 2); // Weakness
        case 0x87A363: return ivec2(3, 2); // Poison
        case 0x736156: return ivec2(4, 2); // Wither
        case 0xF87D23: return ivec2(5, 2); // Health Boost
        case 0x2552A5: return ivec2(6, 2); // Absorption
        // case 0xF82423: return ivec2(7, 2); // Saturation (Duplicate of Instant Health)
        case 0x94A061: return ivec2(0, 3); // Glowing
        case 0xCEFFFF: return ivec2(1, 3); // Levitation
        case 0x59C106: return ivec2(2, 3); // Luck
        case 0xC0A44D: return ivec2(3, 3); // Bad Luck 
        case 0xF3CFB9: return ivec2(4, 3); // Slow Falling
        case 0x1DC2D1: return ivec2(5, 3); // Conduit Power
        case 0x88A3BE: return ivec2(6, 3); // Dolphin's Grace
        case 0x0B6138: return ivec2(7, 3); // Bad Omen
        case 0x44FF44: return ivec2(0, 4); // Hero of the Village
        case 0x292721: return ivec2(1, 4); // Darkness
        case 0x16A6A6: return ivec2(2, 4); // Trial Omen
        case 0xDE4058: return ivec2(3, 4); // Raid Omen
        case 0xBDC9FF: return ivec2(4, 4); // Wind Charged
        case 0x78695A: return ivec2(5, 4); // Weaving
        case 0x99FFA3: return ivec2(6, 4); // Oozing
        case 0x8C9B8C: return ivec2(7, 4); // Infested

        case 0x8D82E6: return ivec2(6, 7); // Turtle Master
        case 0x8D85E6: return ivec2(5, 7); // Turtle Master (Enhanced)
        case 0x385DC6: return ivec2(4, 7); // No Effects
        case 0xF800F8: return ivec2(3, 7); // Uncraftable
        case 0xFFFFFF: return ivec2(2, 7); // Lingering Splash

        default: return ivec2(0, 0); // Swirl
    }
}

// Sizes
const float tileSizeInverse = 1.0 / 8.0;
vec2 atlasSize = textureSize(Sampler0, 0);
vec2 atlasSizeInverse = 1.0 / atlasSize;
vec2 texturePixelSize = atlasSize * (1.0 / 64.0);
vec2 texturePixelSizeInverse = 1.0 / texturePixelSize;

// Declarations
vec2 uv = texCoord0;
vec4 tintColor = particleTint;

vec4 getParticleColor() {
    vec2 maxUV = ceil(texCoord0 * texturePixelSize) * texturePixelSizeInverse;
    bool isPotionParticle = ivec4(texture(Sampler0, maxUV - atlasSizeInverse) * 255.0 + 0.5) == potionParticleIdentifier;

    if (isPotionParticle) {
        vec2 coord = getPotionCoordOffset(tintColor.rgb);
        if (coord != ivec2(0) && coord.y != 7) tintColor = vec4(1.0);
        coord += fract(texCoord0 * texturePixelSize);
        uv = mix(maxUV - texturePixelSizeInverse, maxUV, coord * tileSizeInverse);
    }

    vec4 color = texture(Sampler0, uv) * tintColor * lightColor * ColorModulator;
    if (color.a < 0.1) discard;
    return color;
}