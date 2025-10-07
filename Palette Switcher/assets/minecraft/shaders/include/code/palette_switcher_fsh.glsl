#version 330

flat in ivec4 palette[8];

// Oklab Conversion (from chatgpt, bc im lazy)
vec3 rgb2xyz(vec3 c){
    c = clamp(c, 0.0, 1.0);
    c = mix(c/12.92, pow((c+0.055)/1.055, vec3(2.4)), step(0.04045, c));
    return vec3(
        dot(c, vec3(0.4124,0.3576,0.1805)),
        dot(c, vec3(0.2126,0.7152,0.0722)),
        dot(c, vec3(0.0193,0.1192,0.9505))
    );
}

vec3 xyz2lab(vec3 c){
    vec3 n = c / vec3(0.95047,1.0,1.08883);
    n = mix(pow(n, vec3(1.0/3.0)), 7.787*n + 16.0/116.0, step(n, vec3(0.008856)));
    return vec3(
        116.0 * n.y - 16.0,
        500.0 * (n.x - n.y),
        200.0 * (n.y - n.z)
    );
}

vec3 rgb2lab(vec3 c){
    return xyz2lab(rgb2xyz(c));
}

vec3 hexToRgb(int h) {
    float r = float((h >> 16) & 0xFF) / 255.0;
    float g = float((h >> 8) & 0xFF) / 255.0;
    float b = float(h & 0xFF) / 255.0;
    return vec3(r, g, b);
}

vec4 getPaletteColor() {
    vec3 color = vec3(0.0);

// Dither
    ivec2 ditherScale = textureSize(DitherSampler, 0) * DITHER_SCALE;
    vec2 ditherCoord = mod(gl_FragCoord.xy, ditherScale) * (1.0 / ditherScale);
    float ditherTexture = texture(DitherSampler, ditherCoord).r * DITHER_AMOUNT * 2.0 + 1.0 - DITHER_AMOUNT;
    vec3 dither = texture(InSampler, texCoord).rgb * ditherTexture;

// Luminance Mode
#if COLOR_MODE == 0
    int id = clamp(int(dot(dither, vec3(0.2126, 0.7152, 0.0722)) * 31.0), 0, 31);
    #if AUTO_LUM_SORTING == 1
        int hex = palette[int(floor(id / 4.0))][id % 4];
        color = hexToRgb(hex);
    #else
        color = texture(PaletteSampler, vec2((id + 0.5) * (1.0 / 32.0), 0.5)).rgb;
    #endif

// Nearest Color Mode
#elif COLOR_MODE == 1
    float closestDist = 1e20;
    color = texture(PaletteSampler, vec2(1.5 / 32.0, 0.5)).rgb;
    for (int i = 1; i <= 32; i++) {
        vec3 sample = texture(PaletteSampler, vec2((i + 0.5) / 32.0, 0.5)).rgb;
    #if OKLAB_COMPARISONS == 0
        float dist = distance(sample, dither);
    #elif OKLAB_COMPARISONS == 1
        float dist = distance(rgb2lab(sample), rgb2lab(dither));
    #endif
        if (dist < closestDist) {
            color = sample;
            closestDist = dist;
        }
    }
#endif

    return vec4(color, 1.0);
}