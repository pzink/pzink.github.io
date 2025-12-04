import os
from pathlib import Path
import subprocess

def optimize_png(input_path, output_path, quality=80):
    subprocess.run([
        'cwebp', '-q', str(quality), str(input_path), '-o', str(output_path)
    ], check=True)

images_dir = Path('images')
optimized_dir = images_dir / 'optimized'
os.makedirs(optimized_dir, exist_ok=True)

for img_path in images_dir.glob('*.png'):
    out_path = optimized_dir / (img_path.stem + '.webp')
    optimize_png(img_path, out_path)
    print(f"Optimized: {img_path} -> {out_path}")
