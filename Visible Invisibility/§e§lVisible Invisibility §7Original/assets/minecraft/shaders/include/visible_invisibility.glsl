#version 150

// 0.9647058823529412 invis vertexColor
// 127.5 == black
// 191.25 == transparent
// 63.75 == yellow
// sry the code is bad i made it a while ago and am too lazy to fix

vec4 getParticleColor(vec4 color, vec4 particleColor) {
    if (round(particleColor.rgb * 1000000) == vec3(964706)) {
        float alpha = round(color.a * 100.0);
        if (alpha > 60.0) {
            discard;
        }
        if (alpha == 25.0) {
            color.rgb = vec3(1.0, 1.0, 0.34);
        }
        if (alpha == 50.0) {
            color.rgb = vec3(0.0);
        }
    } else {
        if (color.rgb == vec3(1.0, 0.0, 0.0)) {
            discard;
        } else {
            color *= particleColor;
        }
    }
}