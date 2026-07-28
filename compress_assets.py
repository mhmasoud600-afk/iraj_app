import os
import subprocess

# تنظیمات فشرده‌سازی
AUDIO_BITRATE = "64k"  # کیفیت صدا (کافی برای موبایل)
IMAGE_QUALITY = "25"   # عدد بین 1 تا 31 (هر چه بیشتر، حجم کمتر و کیفیت پایین‌تر - 25 عالی است)
ASSETS_PATH = "assets" # مسیر پوشه است‌های شما

def compress_media():
    for root, dirs, files in os.walk(ASSETS_PATH):
        for file in files:
            file_path = os.path.join(root, file)
            ext = file.lower().split('.')[-1]
            
            # فشرده‌سازی صدا (MP3)
            if ext == 'mp3':
                print(f"--- Compressing Audio: {file}")
                temp_file = file_path + ".temp.mp3"
                cmd = f'ffmpeg -i "{file_path}" -codec:a libmp3lame -b:a {AUDIO_BITRATE} "{temp_file}" -y'
                subprocess.run(cmd, shell=True)
                os.replace(temp_file, file_path)

            # فشرده‌سازی عکس (JPG / JPEG)
            elif ext in ['jpg', 'jpeg']:
                print(f"--- Compressing Image: {file}")
                temp_file = file_path + ".temp.jpg"
                cmd = f'ffmpeg -i "{file_path}" -qscale:v {IMAGE_QUALITY} "{temp_file}" -y'
                subprocess.run(cmd, shell=True)
                os.replace(temp_file, file_path)
            
            # فشرده‌سازی PNG (تبدیل به فرمت بهینه شده)
            elif ext == 'png':
                print(f"--- Optimizing PNG: {file}")
                temp_file = file_path + ".temp.png"
                cmd = f'ffmpeg -i "{file_path}" -pred mixed -pix_fmt pal8 "{temp_file}" -y'
                subprocess.run(cmd, shell=True)
                os.replace(temp_file, file_path)

if name == "__main__":
    print("🚀 Starting Compression...")
    compress_media()
    print("✅ All assets compressed successfully!")