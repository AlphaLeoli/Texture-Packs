#version 150

bool isBobberTooClose(float dist, float alpha) {
    alpha = round(alpha * 100);
    return dist < 0.355 && alpha < 100;
}