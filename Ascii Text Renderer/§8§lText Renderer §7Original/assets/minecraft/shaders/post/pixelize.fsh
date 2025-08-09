/* Notes:

You may be wondering why I have an entire pixelation shader instead of just simply sampling the texcoord at a floored position.
This is because you get very ugly gaps in lines, and that's bad for what I'm trying to do here. By only allowing these 8x8 pixels
to be black if there are 40+ pixels in the area that are black, you can get nice continuations of lines. However, this requires
you to loop through 64 pixels for each pixel on the screen, which is obviously pretty costly. I don't know how to mitigate this,
at least using Minecraft Vanilla's shaders system. So sorry if it lags.

Another thing that might seem weird is the `int id = int(dot(pixelColor, vec3(1.0, 2.0, 3.0)));` calculation that is found in both
this shader and the ascii.fsh shader. The formula doesn't actually mean anything, it was just a nice way to avoid looping or making
lots of if statements or switch cases. It works by mapping the r, g, and b channels to the numbers 1 through 3 respectively. Then, it
adds all the mapped values together (ex: because purple is 1 r and 1 b, it can be id'd as 4 because 1 + 3 = 4). 

Also ik i can just useone color channel to represent every possible thing, but I'm just not gonna do that just bc. And ik there are so many
optimizations that can be done, but I'm very tired with making this pack. I started doing this a long long time ago when I was very inexperienced
with shaders, so now that I can see all my mistakes I'm very overwhelmed. I've been trying to add respackopts support to this for so long and i
figured out that it was an issue with respackopts and not me, so i'm just not going to support it. i am finally free from this project </3
*/

#version 150

#moj_import <minecraft:config.glsl>

uniform sampler2D InSampler;

uniform vec2 InSize;

in vec2 texCoord;

out vec4 fragColor;

// Pixelation Calculations
const int pixelSize = 8;
vec2 texelSize = 1.0 / InSize;

// Color Mappings
const vec3 pixelColors[5] = vec3[5] (
    vec3(0.0, 0.0, 0.0), // Black
    vec3(1.0, 0.0, 0.0), // Red
    vec3(0.0, 1.0, 0.0), // Green
    vec3(0.0, 0.0, 1.0), // Blue
    vec3(1.0, 0.0, 1.0)  // Purple
);

// Counter for amount of pixels of each color in area
int colorCounts[5] = int[5] (
    0, 0, 0, 0, 0
);

void main() {
    vec2 corner = floor(texCoord / (texelSize * pixelSize)) * (texelSize * pixelSize);

    // Loop through each pixel in an 8x8 area, and count how many colors are there
    for (int y = 0; y < pixelSize; y++) {
        for (int x = 0; x < pixelSize; x++) {
            vec2 offset = vec2(float(x) + 0.5, float(y) + 0.5) * texelSize; 
            vec3 pixelColor = texture(InSampler, corner + offset).rgb;

            int id = int(dot(pixelColor, vec3(1.0, 2.0, 3.0)));
            colorCounts[id]++; //
        }
    }

    // Check which color appears the most, and set the final color to that.
    int finalColor = 1;
    if (colorCounts[0] >= 45) finalColor = 0;
    else if (colorCounts[1] >= 32) finalColor = 1;
    else for (int i = 2; i < 5; i++) {
        if (colorCounts[i] > colorCounts[finalColor]) {
            finalColor = i;
        }
    }

    fragColor = vec4(pixelColors[finalColor], 1.0);
}