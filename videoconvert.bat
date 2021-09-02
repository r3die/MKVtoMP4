for /R %f IN (*.mkv) DO ffmpeg -i "%f" -c copy "output.mp4"
