#version 150

float time = GameTime * speed;

float getLeavesZOffset() {
    if (round(texture(Sampler0, UV0).a * 1000.0) != 992.0) return 0.0;
    float x = abs(Position.x - 8.0);
    float z = abs(Position.z - 8.0);

    float xWave = 1.1 * height * sin((round(x * frequency) + time * 0.9));
    float zWave = 0.9 * height * cos((round(z * frequency) + time * 1.1));

    return (xWave + zWave) * 0.25;
}

float getLeavesXOffset() {
    if (round(texture(Sampler0, UV0).a * 1000.0) != 992.0) return 0.0;
    float x = abs(Position.x - 8.0);
    float z = abs(Position.z - 8.0);

    float xWave = 1.1 * height * cos((round(x * frequency) + time * 0.9));
    float zWave = 0.9 * height * sin((round(z * frequency) + time * 1.1));

    return (xWave + zWave) * 0.25;
}