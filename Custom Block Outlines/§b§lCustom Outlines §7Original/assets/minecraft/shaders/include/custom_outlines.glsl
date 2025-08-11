#version 150

// Options
#define red   0
#define green 255
#define blue  255
#define alpha 0.75
#define width 2.0 // 0.0 to 10.0 works best

// Code
vec4 getColor(vec4 col) {
    if (col == vec4(0.0, 0.0, 0.0, 0.4)) return vec4(red / 255, green / 255, blue / 255, alpha);
    else return col;
}