build_all=$1
out_dir=$2
base_dir=$3

echo "Getting current states..."

file="public/routes/routes.txt"

# create set of previous states
declare -A prev_path_hash
while IFS= read -r line; do
    read -ra parts <<< "$line"
    path="${parts[0]}"
    hash="${parts[1]}"
    prev_path_hash["$path"]="$hash"
done < "$file"

# run crawler
echo "Running crawler..."
bash scripts/crawler.sh public/routes-tmp

# compare current states with previous states
echo "Comparing current states with previous states..."
file="public/routes-tmp/routes.txt"

err=0

# for each lines
while IFS= read -r line; do
    read -ra parts <<< "$line"
    path="${parts[0]}"
    hash="${parts[1]}"
    theme="${parts[2]}"
    title="${parts[3]}"
    build=false
    if [ "$build_all" = "true" ]; then
        build=true
    else
        # if the state has changed or new state is detected
        if [ "${prev_path_hash[$path]}" != "$hash" ]; then
            echo "Detected change in $path"
            build=true
        fi
    fi

    out_dir=public/$(dirname $path)/
    out_file=$(basename $path .md).html
    out_file_pdf=$(basename $path .md).pdf
    mkdir -p $out_dir
    echo "Building $out_dir$out_file"

    if [ ! -f $out_dir$out_file ]; then
        build=true
    fi

    if [ "$build" = "true" ]; then
        echo "Building slides..."
        {
            if [ -z "$theme" ]; then
                pnpx @marp-team/marp-cli@latest -I $(dirname $path) --output $out_dir
                pnpx @marp-team/marp-cli@latest -I $(dirname $path) --output $out_dir --pdf --allow-local-files
            else
                echo "Building slides with theme public/themes/$theme.css"
                pnpx @marp-team/marp-cli@latest -I $(dirname $path) --output $out_dir --theme public/themes/$theme.css
                pnpx @marp-team/marp-cli@latest -I $(dirname $path) --output $out_dir --theme public/themes/$theme.css --pdf --allow-local-files
            fi
            mv $out_dir$out_file_pdf $out_dir$title.pdf
        } || {
            err=1
        }
        cp -r $(dirname $path)/img $out_dir
    fi
done < "$file"

# update routes
echo "Updating routes..."
cp -r public/routes-tmp/* public/routes/

# remove temporary files
echo "Removing temporary files..."
rm -r public/routes-tmp