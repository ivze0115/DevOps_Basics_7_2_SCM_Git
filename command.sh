#!/bin/bash

# Loop from 1 to 20
for i in {1..20}; do
    filename=$(printf "%02d.txt" "$i")
    tr -dc 'A-Za-z0-9' </dev/urandom | head -c 100 > "$filename"
done

echo "Created 1.txt to 20.txt with random text data."
