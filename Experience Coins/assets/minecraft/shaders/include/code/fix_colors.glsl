// Remove the green tint on experience orbs
if (0.0 <= tintColor.r && tintColor.r <= 1.0 &&
    0.992 <= tintColor.g && tintColor.g <= 1.0 &&
    0.0 <= tintColor.b && tintColor.b <= 0.2) {
    color *= lightMapColor;
} else { color *= vertexColor; }

// Fix the transparency from the glint removal
if (abs(texture(Sampler0, texCoord0).a - 0.87) <= 0.005) color.a = 1.0;