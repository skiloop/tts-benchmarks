#!/bin/env bash

dst_path=${DST_PATH:-~/.local/bin/}

for file in $(ls -A ./scripts); do
    ln -sf $(pwd)/scripts/$file $dst_path/$file
done
