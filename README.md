# xml-to-csv-converter

Bash scripts that convert a university's student and faculty records from XML to CSV, and pull unique values out of the results. They use only standard Unix tools: `grep -P`, `sed`, `awk`, `tr`, `sort` and `uniq`. `xml-to-csv.sh` needs GNU grep (for `-P`) and a UTF-8 locale, e.g. `export LC_ALL=C.UTF-8`.

> Coursework for the University of Southampton Data Management module (COMP1314, 2024). All the data is synthetic: the names, IDs, addresses and the university itself are generated.

## Prerequisites

- Bash with GNU `grep` (for `-P`), `sed`, `awk`, `tr`, `sort` and `uniq`. On Windows, use Git Bash (bundled with [Git for Windows](https://git-scm.com/download/win)); on Linux these are standard. macOS's BSD `grep` has no `-P`, so install GNU grep first.
- A UTF-8 locale: `export LC_ALL=C.UTF-8` (already the default in Git Bash).

No API keys or other setup are needed.

## Run

From this folder in Git Bash:

```bash
export LC_ALL=C.UTF-8
./xml-to-csv.sh students.xml          # writes students.csv
./xml-to-csv.sh faculty.xml           # writes faculty.csv
./unique-names.sh students.csv students.txt
```

The output file names are fixed: an input named exactly `students.xml` writes `students.csv`, and any other input is treated as faculty data and writes `faculty.csv`, both in the current folder. Running the commands above overwrites the committed CSVs with freshly generated copies.

## Test

The committed `students.csv`, `faculty.csv` and `students.txt` are the expected outputs. To check the scripts reproduce them without overwriting anything, run them in a temporary copy and compare (`--strip-trailing-cr` ignores the CRLF line endings Git may add on Windows checkouts):

```bash
tmp=$(mktemp -d)
cp *.xml *.sh "$tmp"
(cd "$tmp" && ./xml-to-csv.sh students.xml && ./xml-to-csv.sh faculty.xml && ./unique-names.sh students.csv students.txt)
for f in students.csv faculty.csv students.txt; do diff -q --strip-trailing-cr "$f" "$tmp/$f" && echo "$f OK"; done
```

## Scripts

### `xml-to-csv.sh` converts XML to CSV

```bash
./xml-to-csv.sh students.xml   # -> students.csv
./xml-to-csv.sh faculty.xml    # -> faculty.csv
```

It builds the CSV header from the XML tag names, strips the tags, removes stray commas and carriage returns, writes `NULL` for empty fields, and joins each record's lines into one row. `students.xml` has 19 fields per record (student, module, staff, location and marks), and `faculty.xml` has 4.

### `unique-names.sh` lists unique values

```bash
./unique-names.sh students.csv names.txt
```

It writes the sorted, de-duplicated values of the first column to the output file, skipping the header.

## Data

| File | Description |
|---|---|
| `students.xml` / `students.csv` | Student–module enrolments with marks |
| `faculty.xml` / `faculty.csv` | Faculty, building and room records |
| `students.txt` | Output of `unique-names.sh students.csv students.txt` (5,435 unique student names) |
