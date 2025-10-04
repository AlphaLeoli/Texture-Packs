#version 150

const int pixelSize = 8;
vec2 newRes = OutSize / pixelSize;

const vec2 outlineChar[4] = vec2[](
    vec2(12.0, 5.0), // Red,    "\"
    vec2(15.0, 2.0), // Green,  "/"
    vec2(12.0, 7.0), // Blue,   "|"
    vec2(13.0, 2.0)  // Purple, "-"
);

const vec2 fillChar[10] = vec2[](
    vec2(0.0, 0.0),  // 0,  " "
    vec2(10.0, 3.0), // 2,  ":"
    vec2(14.0, 5.0), // 5,  "^"
    vec2(12.0, 3.0), // 7,  "<"
    vec2(13.0, 3.0), // 10, "="
    vec2(13.0, 6.0), // 13, "m"
    vec2(2.0, 3.0),  // 16, "2"
    vec2(7.0, 6.0),  // 18, "g"
    vec2(3.0, 2.0),  // 20, "#"
    vec2(0.0, 4.0)   // 23, "@"
);

const vec3 white = vec3(1.0);
const vec3 black = vec3(0.0);
const vec3 darkPurple = vec3(0.15, 0.05, 0.15);
const vec3 lightPurple = vec3(0.6, 0.4, 0.5);

// Main Code
vec4 getAsciiColor() {
    vec3 inColor = texture(InSampler, texCoord).rgb;
    vec2 scaledCoord = texCoord * newRes;
    vec2 newCoord = floor(scaledCoord) / newRes;
    vec3 minecraft = texture(MinecraftSampler, newCoord).rgb;
    float lum = dot(minecraft.rgb, vec3(0.21, 0.72, 0.07));
    float id = floor(lum * 9.0) / 9.0;

    // Map Characters
    vec2 character;
    int outlineID = int(dot(inColor, vec3(1.0, 2.0, 3.0))) - 1;
    if (outlineID >= 0) character = outlineChar[outlineID];
    else if (outlinesOnly) character = vec2(0.0, 0.0);
    else character = fillChar[int(clamp(id * 9.0, 0.0, 9.0))];

    // Color Options
    float multiplier = (2.0 - (id));
    minecraft *= multiplier;
    vec3 grayscale = vec3(id) * multiplier;
    vec3 hacker = vec3(0.0, id, 0.0) * multiplier;
    vec3 unpixelizedMinecraft = texture(MinecraftSampler, texCoord).rgb;

    // Apply Color
    vec2 offset = fract(scaledCoord);
    vec2 asciiCoord = (character + vec2(offset.x, 1.0 - offset.y)) * 0.0625;
    float asciiColor = texture(AsciiSampler, asciiCoord).r;
    vec3 color = mix(backgroundColor, textColor, step(0.999, asciiColor));

    return vec4(color, 1.0);
}