clustalw -INFILE=SUP35_10seqs.fa
clustalw -INFILE=SUP35_10seqs.fa -OUTFILE=SUP35_10seqs.clustalw
clustalw -INFILE=SUP35_10seqs.fa -OUTPUT=FASTA -OUTFILE=SUP35_10seqs.clustalw.fa

muscle   -in SUP35_10seqs.fa -out SUP35_10seqs_muscle.fa
mafft --auto SUP35_10seqs.fa >SUP35_10seqs_mafft.fa
kalign <SUP35_10seqs.fa >SUP35_10seqs_kalign.fa
t_coffee -infile=SUP35_10seqs.fa -outfile=SUP35_10seqs_tcoffee.fa
prank -d=SUP35_10seqs.fa -o=SUP35_10seqs_prank.fa


clustalw -INFILE=SUP35_250seqs.fa OUTPUT=FASTA -OUTFILE=SUP35_250seqs.clustalw.fa
muscle -in SUP35_250seqs.fa -out SUP35_250seqs_muscle.fa
mafft --auto SUP35_250seqs.fa >SUP35_250seqs_mafft.fa
kalign <SUP35_250seqs.fa >SUP35_250seqs_kalign.fa
t_coffee -infile=SUP35_250seqs.fa -outfile=SUP35_250seqs_tcoffee.fa
prank -d=SUP35_250seqs.fa -o=SUP35_250seqs_prank.fa

transeq -sequence SUP35_10seqs.fa -outseq SUP35_10seqs.t.faa
getorf -sequence SUP35_10seqs.fa -outseq SUP35_10seqs.g.faa -noreverse -minsize 500

clustalw -INFILE=SUP35_10seqs.g.faa -OUTFILE=SUP35_10seqs.clustalw.faa -OUTPUT=FASTA -TYPE=protein
clustalo --infile=SUP35_10seqs.g.faa --outfile=SUP35_10seqs.clustalo.faa --verbose
muscle -in SUP35_10seqs.g.faa -out SUP35_10seqs_muscle.faa
mafft --auto SUP35_10seqs.g.faa >SUP35_250seqs_mafft.fa
kalign <SUP35_10seqs.faa >SUP35_10seqs_kalign.faa
t_coffee -infile=SUP35_10seqs.faa -outfile=SUP35_10seqs_tcoffee.faa
prank -d=SUP35_10seqs.faa -o=SUP35_10seqs_prank.faa

muscle -in SUP35_2addseqs.fa -out SUP35_2addseqs_muscle.fa
muscle -profile -in1 SUP35_250seqs_muscle.fa -in2 SUP35_2addseqs.fa -out SUP35_252seqs_muscle.fa
mafft --auto SUP35_2addseqs.fa > SUP35_2addseqs_mafft.fa
mafft --add SUP35_2addseqs_mafft.fa SUP35_250seqs_mafft.fa > SUP35_252seqs_mafft.fa

