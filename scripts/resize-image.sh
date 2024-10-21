
find slides -type d -name 'img-original' -print | grep -v "templates/" | while read -r img_original_dir; do
  img_dir=$(echo $img_original_dir | sed 's/img-original/img/')

  # resize images from img-original to img
  mkdir -p $img_dir

  # for each images (all files)
  find $img_original_dir -type 'f' -print | while read -r file; do
    echo "Processing $file"
    filename=$(basename $file)
    # filename without extension
    filename_no_ext=$(echo $filename | sed 's/\.[^.]*$//')
    out_file=$img_dir/$filename_no_ext.webp

    
    width=$(identify -format "%w" $file)
    resolution=1024
    # if the image is already resized, skip
    if [ $width -le $resolution ]; then
      echo "Skip resizing"
      convert $file $out_file
      continue
    fi

    # resize image
    convert $file -resize ${resolution}x $out_file
  done
done