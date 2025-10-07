#version 330

float time = GameTime * speed;

// I might have made this a lot more complicated with sum of sines and
// fractal brownian motion and things like that, but i think the simplicity
// fits into minecraft a bit more. In the future, I may make a "realistic water"
// texture pack that uses all those + more, but for now it will remain simple.
float getWaveOffset() {
    if (round(texture(Sampler0, UV0).a * 1000.0) != 706.0) return 0.0;
    float x = abs(Position.x - 8.0);
    float z = abs(Position.z - 8.0);

    float xWave = 1.1 * height * sin((round(x * frequency) + time * 0.9));
    float zWave = 0.9 * height * cos((round(z * frequency) + time * 1.1));

    return (xWave + zWave) * 0.25;
}