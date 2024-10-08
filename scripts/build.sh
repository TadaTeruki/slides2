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
    mkdir -p $out_dir
    echo "Building $out_dir$out_file"

    if [ ! -f $out_dir$out_file ]; then
        build=true
    fi

    if [ "$build" = "true" ]; then
        echo "Building slides..."
        {
            echo $out_dir$out_file
            pnpx @marp-team/marp-cli -I $(dirname $path) --output $out_dir
        } || {
            err=1
        }
    fi
done < "$file"

if [ $err = 0 ]; then
    # update routes
    echo "Updating routes..."
    cp public/routes-tmp/routes.jsonl public/routes/routes.jsonl
    cp public/routes-tmp/routes.txt public/routes/routes.txt
fi

# remove temporary files
echo "Removing temporary files..."
rm -r public/routes-tmp