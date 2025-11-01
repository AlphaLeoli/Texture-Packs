#version 330

float time = GameTime * speed;

float getWaveOffset() {
    if (round(texture(Sampler0, UV0).a * 1000.0) != 706.0) return 0.0;
    float x = abs(Position.x - 8.0);
    float z = abs(Position.z - 8.0);

    float xWave = 1.1 * height * sin((round(x * frequency) + time * 0.9));
    float zWave = 0.9 * height * cos((round(z * frequency) + time * 1.1));

    return (xWave + zWave) * 0.25;
}

/*
To make it repeat every 3.2 seconds:
    - Make sure the last multiplier of both waves are 1.0
    - Set the speed constant to 2356.194490192345
*/