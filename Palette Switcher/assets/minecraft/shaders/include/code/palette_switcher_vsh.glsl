#version 330

flat out ivec4 palette[8];

#if COLOR_MODE == 0 && AUTO_LUM_SORTING == 1
    float luminance(vec3 c) {
        return dot(c, vec3(0.2126, 0.7152, 0.0722));
    }

    int scaleRGB(float value) {
        return int(value * 255.0 + 0.5);
    }

    int rgbToHex(vec3 color) {
        int r = scaleRGB(color.r);
        int g = scaleRGB(color.g);
        int b = scaleRGB(color.b);
        return (r << 16) | (g << 8) | b;
    }

    void sortPalette() {
        // Copy Palette
        vec3 sortedColors[32];
        for (int i = 0; i < 32; i++) {
            sortedColors[i] = texture(PaletteSampler, vec2((i + 0.5) * (1.0 / 32.0), 0.5)).rgb;
        }

        // Bubble Sort
        for (int i = 0; i < 31; i++) {
            for (int j = 0; j < 31 - i; j++) {
                if (luminance(sortedColors[j]) > luminance(sortedColors[j + 1])) {
                    vec3 tmp = sortedColors[j];
                    sortedColors[j] = sortedColors[j + 1];
                    sortedColors[j + 1] = tmp;
                }
            }
        }

        // Compress
        for (int i = 0; i < 8; i++) {
            int index = i * 4;
            palette[i] = ivec4(
                rgbToHex(sortedColors[index]),
                rgbToHex(sortedColors[index + 1]),
                rgbToHex(sortedColors[index + 2]),
                rgbToHex(sortedColors[index + 3])
            );
        }
    }
#else
    void sortPalette() {}
#endif