#!/bin/env bash

dst_path=${DST_PATH:-~/.local/bin}

for file in $(ls -A ./scripts); do
    echo "Linked $file to $dst_path/$file"
    ln -sf $(pwd)/scripts/$file $dst_path/$file
    chmod +x $dst_path/$file
done
