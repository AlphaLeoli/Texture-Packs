import os
import json

output_dir = "gap_models"
os.makedirs(output_dir, exist_ok=True)

for i in range(1, 65):
    data = {
        "parent": "minecraft:item/golden_apple",
        "textures": {
            "layer0": f"minecraft:item/gaps/{i}"
        }
    }
    with open(os.path.join(output_dir, f"{i}.json"), "w") as f:
        json.dump(data, f, indent=2)
