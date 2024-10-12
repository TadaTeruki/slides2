url_origin="https://slides2.peruki.dev/"

find slides -name 'slide.md' -print | grep -v "templates/" | while read -r slide_dir; do
  url=$url_origin$(echo $slide_dir | sed 's/\/slide.md//')/slide
  img_dir=$(echo $slide_dir | sed 's/slide.md/img/')
  mkdir -p $img_dir
  echo "Processing $url"

  # create qr code for the slide
  qrencode -o $img_dir/qr.png $url --background=ffffff --foreground=000000
done