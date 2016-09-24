#!/bin/bash
echo "The log for this script can be found in the file contigformatting_log_P.txt"
exec &> contigformatting_log_P.txt
mkdir FormattedContigs_P
for file in ./AllContigs_*.fasta; do
	for i in P{1..20}; do
		cat AllContigs_"$i".fasta | paste - - | cut -f 1,4 > "$i";
		awk '{ printf (">%s_%s\n%s\n", FILENAME, NR, $2 )}' "$i" > FormattedContigs_P/FormattedContigs_"$i".fasta;
		rm -rf "$i";
	done;
done
