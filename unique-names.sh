#!/bin/bash
filename="$1"
outputname="$2"
awk -F ',' '{print $1}' "$filename" | tail -n+2 | sort | uniq > "$outputname"
