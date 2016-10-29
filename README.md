A simple genetic algorithm for solving BCP.

How to run:

1. Clone repo

2. List the desired source files in `file_names=( "GEOM20.col" )` in `external/populate.sh`

3. Run `external/populate.sh`

4. Adjust `GRAPH_FILE_PATH`, `CSV_FILE_PATH` and `config` in `lib/bcp.rb`

5. Run `ruby lib/bcp.rb`

6. See the results in the exported CSV file.
