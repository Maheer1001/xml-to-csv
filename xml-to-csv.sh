#!/bin/bash
filename="$1"
linecount=$(wc -l < "$filename")
end=$((linecount - 2))
quit=$((linecount - 1))
if [ "$filename" == "students.xml" ]; then 
	grep -oP '(?<=<)[^<>]+(?=>)' "$filename" | tr -d '/' | uniq | sed -n '4,22p; 23q' | awk 'NR<=18 {printf"%s,", $0; next} 1' > students.csv
	sed -e 's/<[^>]*>//g; s/^ *//g; s/\r//g; /^$/s/^$/NULL/' "$filename" | tr -d ',' | sed -n "4,${end}p; ${quit}q" | \
	awk '((NR-6)%22==0) {printf "%s ", $0; next} ((NR-20)%22==0) {printf "%s\n", $0} ((NR-20)%22!=0) && ((NR-21)%22!=0) && NR%22!=0 {printf "%s,", $0}' >> students.csv
else
	grep -oP '(?<=<)[^<>]+(?=>)' "$filename" | tr -d '/' | uniq | sed -n '3,6p; 7q' | awk 'NR<=3 {printf"%s,", $0; next} 1' > faculty.csv
	sed -e 's/<[^>]*>//g; s/^ *//g; s/\r//g; /^$/d' "$filename" | \
	awk 'NR%4!=0 {printf "%s,", $0} NR%4==0 {printf "%s\n", $0}' >> faculty.csv
fi
