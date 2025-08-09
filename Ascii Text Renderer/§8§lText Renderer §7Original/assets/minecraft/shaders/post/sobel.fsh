#version 150

uniform sampler2D InSampler;
uniform vec2 InSize;

in vec2 texCoord;
out vec4 fragColor;

vec2 texelSize = 1.0 / InSize;

const float kernelX[9] = float[](
    -1.0, 0.0, 1.0,
    -2.0, 0.0, 2.0,
    -1.0, 0.0, 1.0
);

const float kernelY[9] = float[](
    -1.0, -2.0, -1.0,
    0.0,  0.0,  0.0,
    1.0,  2.0,  1.0
);

const vec2 offsets[9] = vec2[](
    vec2(-1, -1), vec2(0, -1), vec2(1, -1),
    vec2(-1,  0), vec2(0,  0), vec2(1,  0),
    vec2(-1,  1), vec2(0,  1), vec2(1,  1)
);

const vec3 colorMap[4] = vec3[](
    vec3(0.0, 0.0, 1.0), // Blue
    vec3(1.0, 0.0, 0.0), // Red
    vec3(1.0, 0.0, 1.0), // Purple
    vec3(0.0, 1.0, 0.0)  // Green
);

void main() {
    float Gx = 0.0;
    float Gy = 0.0;

    int idx = 0;
    for (int y = -1; y <= 1; y++) {
        for (int x = -1; x <= 1; x++) {
            vec2 offset = vec2(float(x), float(y)) * texelSize;
            vec3 sample = texture(InSampler, texCoord + offset).rgb;
            float intensity = dot(sample, vec3(0.299, 0.587, 0.114));
            Gx += kernelX[idx] * intensity;
            Gy += kernelY[idx] * intensity;
            idx++;
        }
    }

    for (int i = 0; i < 9; i++) {
        vec3 sample = texture(InSampler, texCoord + offsets[i] * texelSize).rgb;
        float intensity = dot(sample, vec3(0.299, 0.587, 0.114));
        Gx += kernelX[i] * intensity;
        Gy += kernelY[i] * intensity;
    }

    float edgeStrength = length(vec2(Gx, Gy));
    if (edgeStrength == 0.0) discard;

    // Map Colors
    float angle = degrees(atan(Gy, Gx));
    if (angle < 0.0) angle += 360.0;
    int id = int(mod((angle + 22.5) / 45.0, 8.0)) % 4;
    vec3 color = colorMap[id];

    fragColor = vec4(color, 1.0);
}
