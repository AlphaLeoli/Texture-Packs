#version 150

// Whether or not the background is colorful
#define colorEnabled (false) // Default false

// The strength of the paper overlay. If you set this to 1.0, then
// there will be no Minecraft background and it will just all be paper.
// Likewise, if you turn it to 0.0 then there wouldn't be a paper overlay.
#define overlayStrength (0.8) // Default 0.8

// The outlines are slightly offset, so the strength is how far
// out they wiggle, and the frequency is how often they wiggle.
// You can also disable the wiggling by turning the strength to 0
#define wiggleStrength (0.001) // Default 0.001
#define wiggleFrequency (20.0) // Default 20.0

// There is a border around the screen that is tinted brown.
// This controls how brown it is. You can input 0.0 to disable
// it, or a higher number like 2.0 to strengthen it.
#define vignetteStrength (1.0) // Default 1.0

// Different outline related settings
#define outlineBlur (true) // Default True
#define solidifyBlur (false) // Default false
#define outlineStrength (0.5) // Default 0.5