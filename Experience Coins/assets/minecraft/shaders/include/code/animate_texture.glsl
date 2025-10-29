/* Settings (im looking at u inferno 🙏) */
const float FRAMES = 10.0;
const float ATLAS_WIDTH = 64.0;
const float ANIMATION_SPEED = 10000.0;
/* ----------------------------------------- */

vec2 newCoord = texCoord0;
float frame = round(mod(GameTime * ANIMATION_SPEED, FRAMES));
bool isExperienceOrb = textureSize(Sampler0, 0) == ivec2(ATLAS_WIDTH, ATLAS_WIDTH * FRAMES);
if (isExperienceOrb) { newCoord.y = newCoord.y * (1.0 / FRAMES) + frame * (1.0 / FRAMES); }