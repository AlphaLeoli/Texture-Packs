#version 150

#define width ${w}

vec4 getColor(vec4 col) {
    if (col == vec4(0.0, 0.0, 0.0, 0.4)) return vec4(${r}, ${g}, ${b}, ${a});
    else return col;
}