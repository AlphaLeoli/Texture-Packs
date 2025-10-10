#version 330

ivec2 uvSize = textureSize(Sampler0, 0);

bool isNotHealthBar() {
    return uvSize != ivec2(81, 9);
}