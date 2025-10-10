#version 330

const vec2 centerPixel = vec2(0.5, 0.5);

vec2 texelSize = 1.0 / OutSize;

float sampleColor(vec2 offset) {
    return texture(OutlinesSampler, texCoord + offset).r;
}

const vec2 offsets[25] = vec2[](
    vec2(-2, -2), vec2(-1, -2), vec2(0, -2), vec2(1, -2), vec2(2, -2),
    vec2(-2, -1), vec2(-1, -1), vec2(0, -1), vec2(1, -1), vec2(2, -1),
    vec2(-2,  0), vec2(-1,  0), vec2(0,  0), vec2(1,  0), vec2(2,  0),
    vec2(-2,  1), vec2(-1,  1), vec2(0,  1), vec2(1,  1), vec2(2,  1),
    vec2(-2,  2), vec2(-1,  2), vec2(0,  2), vec2(1,  2), vec2(2,  2)
);

// Main Code

vec4 getFinalColor() {
    // Set Colors
    vec3 minecraftColor = texture(InSampler, texCoord).rgb;                // Default Minecraft color
    vec3 paperColor = texture(PaperSampler, texCoord).rgb;                 // The paper texture
    vec3 luminance = vec3(dot(minecraftColor, vec3(0.299, 0.587, 0.114))); // Grayscale/Lightness
    vec3 paperBrown = vec3(0.87, 0.80, 0.65);                              // Brown tint
    vec3 newColor = luminance;                                             // New background color
    if (colorEnabled) newColor = minecraftColor;

    // Set an offset to wiggle the outlines
    vec2 offset = vec2(
        sin(texCoord.y * wiggleFrequency),
        cos(texCoord.x * wiggleFrequency)
    ) * wiggleStrength;

    // Blur the outlines
    float outlineColor = 0.0;
    if (outlineBlur) {
        for (int i = 0; i < 25; i++) {
            outlineColor += sampleColor(offsets[i] * texelSize + offset);
        }
        outlineColor *= 0.04;
    } else outlineColor = sampleColor(vec2(0.0) + offset);
    if (solidifyBlur) outlineColor = float(outlineColor > 0.0 ? 1.0 : 0.0);
    outlineColor *= outlineStrength;
    outlineColor = 1.0 - outlineColor; // Flip the output

    // Mix Colors
    vec3 color = mix(      // Apply the paper overlay
        newColor,
        paperColor,
        overlayStrength
    );
    color *= outlineColor; // Apply the outlines
    color *= paperBrown;   // Tint the paper brown
    color *= mix(          // Tint the edges darker brown
        vec3(1.0), 
        paperBrown,
        length(centerPixel - texCoord) * vignetteStrength
    );

    return vec4(color, 1.0);
}