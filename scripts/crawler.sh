#!/bin/sh

output_path=$1
output_file="${output_path}/routes"

mkdir -p $output_path

# init files
> "$output_file.jsonl"
> "$output_file.txt"

find slides -name '*.md' -print | grep -v "templates/" | while read -r file; do
  path=$(dirname $file)
  echo "Processing $file"
  target_entries=("title" "info" "date" "session" "tags")
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
  echo "{\"src_path\":\"$path\",\"src_file\":\"$(basename $file)\",$entries_str}," >> "$output_file.jsonl"

  file_hash=$(cat $file | sha256sum)
  file_hash=$(echo $file_hash | cut -d ' ' -f 1)

  echo "$path/$(basename $file) $file_hash" >> "$output_file.txt"
done

echo "Finished."

