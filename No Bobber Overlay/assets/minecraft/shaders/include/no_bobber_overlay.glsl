#version 150

bool isBobber(float alpha) {
    return round(alpha * 100.0) < 100.0;
}

bool isBobberTooClose(float dist, float cutoff) {
    return dist < cutoff;
}

void removeBobberOverlay(float dist, float cutoff, float alpha) {
    if (isBobber(alpha) && isBobberTooClose(dist, cutoff)) discard;
}