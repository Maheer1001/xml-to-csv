# XML to CSV Shell Scripts

Bash scripts that convert a university's student and faculty records from XML to CSV, and pull unique values out of the results. They use only standard Unix tools: `grep -P`, `sed`, `awk`, `tr`, `sort` and `uniq`. `ex1.sh` needs GNU grep (for `-P`) and a UTF-8 locale, e.g. `export LC_ALL=C.UTF-8`.

> Coursework for the University of Southampton Data Management module (COMP1314, 2024). All the data is synthetic: the names, IDs, addresses and the university itself are generated.

## Scripts

### `ex1.sh` converts XML to CSV

```bash
./ex1.sh students.xml   # -> students.csv
./ex1.sh faculty.xml    # -> faculty.csv
```

It builds the CSV header from the XML tag names, strips the tags, removes stray commas and carriage returns, writes `NULL` for empty fields, and joins each record's lines into one row. `students.xml` has 19 fields per record (student, module, staff, location and marks), and `faculty.xml` has 4.

### `ex2.sh` lists unique values

```bash
./ex2.sh students.csv names.txt
```

It writes the sorted, de-duplicated values of the first column to the output file, skipping the header.

## Data

| File | Description |
|---|---|
| `students.xml` / `students.csv` | Student–module enrolments with marks |
| `faculty.xml` / `faculty.csv` | Faculty, building and room records |
| `students.txt` | Output of `ex2.sh students.csv students.txt` (5,435 unique student names) |
