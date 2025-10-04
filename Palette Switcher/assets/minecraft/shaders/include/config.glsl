#version 150

// 0 for Luminance (uses the color in the palette that has the closest brightness to the current pixel. Good for monochrome color palettes)
// 1 for Closest Color (uses the color in the palette that has the closest rgb value to the current pixel. Good for palettes with lots of different colors)
#define COLOR_MODE 1

// Any number 0 to infinity
// The size of the dither effect on the screen. 1 or 2 looks best, you probably don't need to go past that.
#define DITHER_SCALE 1

// Any number from 0.0 to 1.0
// Basically how smooth it is. For 0.0, there is no dither at all. At 1.0, dithering is turned all the way up.
#define DITHER_AMOUNT 0.5

// 0 for false
// 1 for true

// For closest color mode only. If true, it uses oklab (what your eyes see) and for false it uses rgb (what your computer sees).
// Sometimes it looks good on, sometimes it looks good off. It's good to play with it for every palette in order to see what looks best.
#define OKLAB_COMPARISONS 1

// For luminance mode only. This will sort the color palette from darkest to lightest before doing the luminance mode stuff. The only reason you should
// realistically be turning this off is if you know your palette is in the correct order and either want slightly better fps or if you want to test it.
#define AUTO_LUM_SORTING 1