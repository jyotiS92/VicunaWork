#!/bin/bash
echo "The log for this script can be found in the file contigcorrection_log_P.txt"
exec &> contigcorrection_log_P.txt
mkdir corrected_contigs_P tempdir;
for file in FormattedContigs_P/FormattedContigs_*.fasta; do
  for i in P{1..20}; do
    cat FormattedContigs_P/FormattedContigs_"$i".fasta | paste - - | cut -f 2 | awk 'BEGIN{printf ("%s\n", "sequence")}{printf ("%s\n", $1)}' > tempdir/"$i"temp
    cat tempdir/"$i"temp | tr ATCGN TAGCN | rev > tempdir/"$i"tempRC
    paste SequenceLocatorSummary/"$i".txt tempdir/"$i"temp tempdir/"$i"tempRC > tempdir/"$i"concat
    awk '{
      if (NR > 1)
	    print ($0);
      }' tempdir/"$i"concat > tempdir/"$i"concatedited;
    awk '{
      if ($5 > 0)
	    printf (">%s\n%s\n", $1, $7);
      else
      printf (">%s\n%s\n", $1, $6);
    }' tempdir/"$i"concatedited > corrected_contigs_P/"$i"_corrected_contigs.fasta;
  done;
done; rm -rf tempdir;
