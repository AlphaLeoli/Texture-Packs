/* This was the old code, but because it's so vague it keeps out a lot of similarly colored particles. My only choice is to check if it isn't every single other particle.
also yea i understand i could ahve left out a lot of colors andit would still work, and ik it breaks water particles. it's ok tho lol
if (all(lessThan(vec3(0.164, 0.270, 0.580), Color.rgb)) && all(lessThan(Color.rgb, vec3(0.216, 0.361, 0.773)))) vertexColor = vec4(0.0); */

int scaleRGB(float value) {
    return int(value * 255.0 + 0.5);
}

int rgbToHex(vec3 color) {
    int r = scaleRGB(color.r);
    int g = scaleRGB(color.g);
    int b = scaleRGB(color.b);
    return (r << 16) | (g << 8) | b;
}

vec4 getParticleColor(vec4 color) {
    switch (rgbToHex(color.rgb)) {
        case 0x33EBFF: // Speed
        case 0x8BAFE0: // Slowness
        case 0xD9C043: // Haste
        case 0x4A4217: // Mining Fatigue
        case 0xFFC700: // Strength
        case 0xF82423: // Instant Health
        case 0xA9656A: // Instant Damage
        case 0xFDFF84: // Jump Boost
        case 0x551D4A: // Nausea
        case 0xCD5CAB: // Regeneration
        case 0x9146F0: // Resistance
        case 0xFF9900: // Fire Resistance
        case 0x98DAC0: // Water Breathing
        case 0xF6F6F6: // Invisibility
        case 0x1F1F23: // Blindness
        case 0xC2FF66: // Night Vision
        case 0x587653: // Hunger
        case 0x484D48: // Weakness
        case 0x87A363: // Poison
        case 0x736156: // Wither
        case 0xF87D23: // Health Boost
        case 0x2552A5: // Absorption
        // case 0xF82423: // Saturation (Duplicate of Instant Health)
        case 0x94A061: // Glowing
        case 0xCEFFFF: // Levitation
        case 0x59C106: // Luck
        case 0xC0A44D: // Bad Luck 
        case 0xF3CFB9: // Slow Falling
        case 0x1DC2D1: // Conduit Power
        case 0x88A3BE: // Dolphin's Grace
        case 0x0B6138: // Bad Omen
        case 0x44FF44: // Hero of the Village
        case 0x292721: // Darkness
        case 0x16A6A6: // Trial Omen
        case 0xDE4058: // Raid Omen
        case 0xBDC9FF: // Wind Charged
        case 0x78695A: // Weaving
        case 0x99FFA3: // Oozing
        case 0x8C9B8C: // Infested

        case 0x8D82E6: // Turtle Master
        case 0x8D85E6: // Turtle Master (Enhanced)
        case 0x385DC6: // No Effects
        case 0xF800F8: // Uncraftable
        case 0xFFFFFF: // Lingering Splash
            return color;
            break;

        default: {
            if (all(lessThan(vec3(0.164, 0.270, 0.580), color.rgb)) &&
                all(lessThan(color.rgb, vec3(0.216, 0.361, 0.773))))
                return vec4(0.0);
            else return color;
        }
    }
}