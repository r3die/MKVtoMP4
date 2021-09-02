(for %i in (*.mkv) do @echo file '%i') > combine.txt
FFmpeg -f Concat -safe 0 -i combine.txt -c copy "output.mkv"
for /R %f IN (*.mkv) DO ffmpeg -i "%f" -c copy "output.mp4"
