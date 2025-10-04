// If you're on 1.21.1 or earlier, then edit the config found at the top of the 1_21-1_21_1/assets/minecraft/shaders/program/ascii.fsh file
#version 150

// If true, only the outlines render. Try it out, its very interesting
#define outlinesOnly (false)

/* Preset Colors:
Input different combinations of these colors as textColor or backgroundColor
    - minecraft
    - unpixelizedMinecraft
    - black
    - white
    - grayscale
    - hacker (grayscale, but green)
    - lightPurple (low contrast option for text)
    - darkPurple (low contrast option for background)
    - vec3(r, g, b) (the rgb numbers have to be from 0.0 to 1.0)
*/

#define textColor (lightPurple)
#define backgroundColor (vec3(0.15, 0.05, 0.15)) // By default, the custom color is the exact same as inputting darkPurple