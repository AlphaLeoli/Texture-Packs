#version 150

uniform sampler2D DiffuseSampler;
uniform sampler2D AsciiSampler;

uniform vec2 InSize;

in vec2 texCoord;

out vec4 fragColor;

void main() {
    // uv stuff
    float pixelSize = ${size};
    vec2 pixelTransformation = InSize / pixelSize;
    vec2 uv = floor(texCoord * pixelTransformation) / pixelTransformation;

    // color stuff
    vec3 color = texture(DiffuseSampler, uv).rgb;
    float grayscale = dot(color, vec3(0.299, 0.587, 0.114));
    int index = int(round(grayscale * 64.0));

    // map to characters
    vec2 offset;
    switch (index) {
        // case 0:  offset = vec2(0.0, 0.0); break;    // nothing
        // case 1:  offset = vec2(14.0, 2.0); break;   // .
        // case 2:  offset = vec2(0.0, 6.0); break;    // ` , : '
        // case 3:  offset = vec2(11.0, 3.0); break;   // ; 
        // case 4:  offset = vec2(2.0, 2.0); break;    // "
        // case 5:  offset = vec2(13.0, 2.0); break;   // - * ^ _
        // case 6:  offset = vec2(1.0, 2.0); break;    // ! ~ i
        // case 7:  offset = vec2(15.0, 2.0); break;   // | ( { < / \ > } ) l
        // case 8:  offset = vec2(8.0, 15.0); break;   // °
        // case 9:  offset = vec2(11.0, 2.0); break;   // + r x Y ? v t
        // case 10: offset = vec2(13.0, 3.0); break;   // =
        // case 11: offset = vec2(9.0, 4.0); break;    // I f [ ] j % c L
        // case 12: offset = vec2(15.0, 6.0); break;   // o k n 1 7 u
        // case 13: offset = vec2(13.0, 6.0); break;   // m z X V F C s
        // case 14: offset = vec2(8.0, 6.0); break;    // h 3
        // case 15: offset = vec2(4.0, 2.0); break;    // y 4 6 Z & $ S
        // case 16: offset = vec2(15.0, 4.0); break;   // O 2 Q
        // case 17: offset = vec2(5.0, 3.0); break;    // W G 5 M 8 H
        // case 18: offset = vec2(7.0, 6.0); break;    // g R
        // case 19: offset = vec2(0.0, 3.0); break;    // 0
        // case 20: offset = vec2(2.0, 4.0); break;    // B #
        // //
        // //
        // case 23: offset = vec2(0.0, 4.0); break;    // @

        case 0:  offset = vec2(0.0, 0.0); break;  // 0
        case 1:  offset = vec2(14.0, 2.0); break; // 1
        case 2:  offset = vec2(14.0, 2.0); break; // 1
        case 3:  offset = vec2(7.0, 2.0); break;  // 1
        case 4:  offset = vec2(0.0, 6.0); break;  // 2
        case 5:  offset = vec2(12.0, 2.0); break; // 2
        case 6:  offset = vec2(10.0, 2.0); break; // 2
        case 7:  offset = vec2(11.0, 3.0); break; // 3
        case 8:  offset = vec2(11.0, 3.0); break; // 3
        case 9:  offset = vec2(11.0, 3.0); break; // 3
        case 10: offset = vec2(2.0, 2.0); break;  // 4
        case 11: offset = vec2(2.0, 2.0); break;  // 4
        case 12: offset = vec2(13.0, 2.0); break; // 4
        case 13: offset = vec2(15.0, 5.0); break; // 5
        case 14: offset = vec2(14.0, 5.0); break; // 5
        case 15: offset = vec2(10.0, 2.0); break; // 5
        case 16: offset = vec2(1.0, 2.0); break;  // 6
        case 17: offset = vec2(9.0, 6.0); break;  // 6
        case 18: offset = vec2(14.0, 7.0); break; // 6
        case 19: offset = vec2(12.0, 6.0); break; // 7
        case 20: offset = vec2(8.0, 2.0); break;  // 7
        case 21: offset = vec2(12.0, 3.0); break; // 7
        case 22: offset = vec2(11.0, 2.0); break; // 8
        case 23: offset = vec2(2.0, 7.0); break;  // 8
        case 24: offset = vec2(3.0, 7.0); break;  // 8
        case 25: offset = vec2(4.0, 7.0); break;  // 9
        case 26: offset = vec2(9.0, 5.0); break;  // 9
        case 27: offset = vec2(15.0, 3.0); break; // 9
        case 28: offset = vec2(13.0, 3.0); break; // 10
        case 29: offset = vec2(3.0, 6.0); break;  // 10
        case 30: offset = vec2(6.0, 6.0); break;  // 10
        case 31: offset = vec2(9.0, 4.0); break;  // 11
        case 32: offset = vec2(12.0, 4.0); break; // 11
        case 33: offset = vec2(5.0, 2.0); break;  // 11
        case 34: offset = vec2(15.0, 6.0); break; // 12
        case 35: offset = vec2(11.0, 6.0); break; // 12
        case 36: offset = vec2(7.0, 3.0); break;  // 12
        case 37: offset = vec2(3.0, 7.0); break;  // 13
        case 38: offset = vec2(13.0, 6.0); break; // 13
        case 39: offset = vec2(8.0, 5.0); break;  // 13
        case 40: offset = vec2(8.0, 6.0); break;  // 14
        case 41: offset = vec2(9.0, 7.0); break;  // 14
        case 42: offset = vec2(3.0, 3.0); break;  // 14
        case 43: offset = vec2(4.0, 3.0); break;  // 15
        case 44: offset = vec2(6.0, 2.0); break;  // 15
        case 45: offset = vec2(3.0, 5.0); break;  // 15
        case 46: offset = vec2(15.0, 4.0); break; // 16
        case 47: offset = vec2(1.0, 5.0); break;  // 16
        case 48: offset = vec2(2.0, 3.0); break;  // 16
        case 49: offset = vec2(13.0, 4.0); break; // 17
        case 50: offset = vec2(5.0, 3.0); break;  // 17
        case 51: offset = vec2(8.0, 3.0); break;  // 17
        case 52: offset = vec2(7.0, 5.0); break;  // 18
        case 53: offset = vec2(7.0, 6.0); break;  // 18
        case 54: offset = vec2(2.0, 5.0); break;  // 18
        case 55: offset = vec2(2.0, 5.0); break;  // 19
        case 56: offset = vec2(0.0, 3.0); break;  // 19
        case 57: offset = vec2(0.0, 3.0); break;  // 19
        case 58: offset = vec2(2.0, 4.0); break;  // 20
        case 59: offset = vec2(2.0, 4.0); break;  // 20
        case 60: offset = vec2(3.0, 2.0); break;  // 20
        case 61: offset = vec2(3.0, 2.0); break;  // 21
        case 62: offset = vec2(3.0, 2.0); break;  // 21
        case 63: offset = vec2(0.0, 4.0); break;  // 23
        case 64: offset = vec2(0.0, 4.0); break;  // 23
    }

    // translate to ascii coordinate
    vec2 characterSize = vec2(1.0 / 16.0);
    vec2 charUV = offset * characterSize;
    vec2 pixelOffset = mod(texCoord * InSize, pixelSize) / pixelSize;
    pixelOffset.y = 1.0 - pixelOffset.y;
    vec2 AsciiUV = charUV + pixelOffset * characterSize;

    // convert colors!
    vec4 minecraft = vec4(vec3(color), 1.0);
    vec4 hacker = vec4(0.0, grayscale, 0.0, 1.0);
    vec4 desaturated = vec4(vec3(grayscale), 1.0);
    vec4 white = vec4(1.0);
    vec4 mario = vec4(round(color * vec3(3.0, 3.0, 2.0)) / vec3(3.0, 3.0, 2.0), 1.0);

    vec4 newColor = texture(AsciiSampler, AsciiUV);
    if (newColor == vec4(1.0)) {
        newColor = ${colorMode};
    }

    fragColor = newColor;
}
