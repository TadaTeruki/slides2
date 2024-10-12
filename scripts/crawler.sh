#!/bin/sh

output_path=$1
output_file="${output_path}/routes"

mkdir -p $output_path

# init files
> "$output_file.json"
> "$output_file.txt"

echo "[" >> "$output_file.json"

first=true
find slides -name '*.md' -print | grep -v "templates/" | while read -r file; do
  path=$(dirname $file)
  echo "Processing $file"
  target_entries=("title" "description" "date" "session" "tags" "thumbnail")
  entries=()

  for tag in "${target_entries[@]}"; do
    line=$(grep -i -m 1 "^${tag}:" $file)
    value=$(echo $line | cut -d ':' -f 2- | sed 's/^[[:space:]]*//')

    if [ "$tag" = "tags" ]; then
      value=$(echo $value | sed 's/,/","/g' | tr -d '[:space:]')
      value="[\"$value\"]"
    else
      value="\"$value\""
    fi

    entries+=("\"$tag\":$value")
  done
 
  entries_str=$(IFS=,; echo "${entries[*]}")

  if [ "$first" = "true" ]; then
    first=false
  else
    echo "," >> "$output_file.json"
  fi
  echo "{\"src_path\":\"$path\",\"src_file\":\"$(basename $file .md).html\",$entries_str}" >> "$output_file.json"

  file_hash=$(cat $file | sha256sum)
  file_hash=$(echo $file_hash | cut -d ' ' -f 1)

  echo "$path/$(basename $file) $file_hash" >> "$output_file.txt"
done

echo "]" >> "$output_file.json"

echo "Finished."

