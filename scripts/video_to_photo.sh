# ffmpeg -i input.mov -qscale:v 2 -vf "fps=1"  output/frame_%04d.jpg

run() {
    # echo "1 $1"
    # echo "2 $2"
    mkdir -p colmap_frames/"$2"
    ffmpeg -i "$1" -vf "select=not(mod(n\,10))" -vsync vfr -qscale:v 2 colmap_frames/"$2"/frame_%04d.jpg
}



run "$@"