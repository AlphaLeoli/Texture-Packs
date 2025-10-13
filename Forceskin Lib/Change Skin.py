from PIL import Image
import os
from collections import Counter

skin = input("Enter the skin name (ex: skin.png): ")

# Load Skin
image = Image.open(skin).convert("RGBA")
width, height = image.size
pixels = image.load()

# Group colors
i = 0
groups = {}
color_count = Counter()
for x in range(width):
    for y in range(height):
        r, g, b, a = pixels[x, y]
        color_key = f"ivec4({r}, {g}, {b}, {a})"
        groups.setdefault(color_key, []).append(i)
        color_count[color_key] += 1
        i += 1

# Include transparent pixels
if "ivec4(0, 0, 0, 0)" not in groups:
    groups["ivec4(0, 0, 0, 0)"] = []
    color_count["ivec4(0, 0, 0, 0)"] = 0

# Sort groups by most used color first
sorted_colors = sorted(groups.items(), key=lambda x: len(x[1]), reverse=True)
groups = dict(sorted_colors)

# Most used color = default, second most = first entry
most_used_color = sorted_colors[0][0] if sorted_colors else "ivec4(0)"
second_most_color = sorted_colors[1][0] if len(sorted_colors) > 1 else most_used_color

# Generate the skin code
glsl = "#version 150\n\n"
glsl += "ivec4 getSkinColor(int id) {\n"
glsl += "    switch(id) {\n"
for color, ids in groups.items():
    if color == most_used_color:
        continue  # skip most-used; it's for default
    glsl += "       "
    for id in ids:
        glsl += f" case {id}:"
    glsl += f"\n            return {color};\n"
glsl += f"        default: return {most_used_color};\n"
glsl += "    }\n"
glsl += "}"

# Write to file
os.makedirs("assets/minecraft/shaders/include/skins", exist_ok=True)
with open("assets/minecraft/shaders/include/skins/skin.glsl", "w") as f:
    f.write(glsl)

print(f"The {skin} skin code has been generated")
