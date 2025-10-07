#version 330

const int pixelSize = 8;
vec2 texelSize = 1.0 / OutSize;

const vec3 pixelColors[5] = vec3[5] (
    vec3(0.0, 0.0, 0.0), // Black
    vec3(1.0, 0.0, 0.0), // Red
    vec3(0.0, 1.0, 0.0), // Green
    vec3(0.0, 0.0, 1.0), // Blue
    vec3(1.0, 0.0, 1.0)  // Purple
);

int colorCounts[5] = int[5] (
    0, 0, 0, 0, 0
);

// Main Code
vec4 getPixelizedColor() {
    vec2 corner = floor(texCoord / (texelSize * pixelSize)) * (texelSize * pixelSize);

    // Loop through each pixel in an 8x8 area, and count how many colors are there
    for (int y = 0; y < pixelSize; y++) {
        for (int x = 0; x < pixelSize; x++) {
            vec2 offset = vec2(float(x) + 0.5, float(y) + 0.5) * texelSize; 
            vec3 pixelColor = texture(InSampler, corner + offset).rgb;

            int id = int(dot(pixelColor, vec3(1.0, 2.0, 3.0)));
            colorCounts[id]++; //
        }
    }

    // Check which color appears the most, and set the final color to that.
    int finalColor = 1;
    if (colorCounts[0] >= 45) finalColor = 0;
    else if (colorCounts[1] >= 32) finalColor = 1;
    else for (int i = 2; i < 5; i++) {
        if (colorCounts[i] > colorCounts[finalColor]) {
            finalColor = i;
        }
    }

    return vec4(pixelColors[finalColor], 1.0);
}