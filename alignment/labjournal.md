# Alignment 
The main goal is to compare some multimple alignment algorithms.<br>
## 1. Materials and methods
I work with nucleotide sequences of gene of translation termination factor (SUP35) from different species of yeasts<br>
In this project I use the following programms:<br>
- CLUSTAL 2.1<br>
- MUSCLE v3.8.1551<br>
- MAFFT v7.475<br>
- Kalign (3.3)<br>
- T-COFFEE Version_13.41.0.28bdc39<br>
- PRANK v.170427<br>
- transeq (Version: EMBOSS:6.6.0.0)<br>
- getorf (Version: EMBOSS:6.6.0.0)<br>
## 2. Using 6 various alignment algorithms on 10 DNA sequences
### clustalw
By default we generate the alignment in clustalw format<br>
```bash
clustalw -INFILE=./data/raw_data/SUP35_10seqs.fa
```
time:
```bash
real    0m3,747s
user    0m3,732s
sys     0m0,015s
```
Determining the output file:
```bash
clustalw -INFILE=./data/raw_data/SUP35_10seqs.fa -OUTFILE=./data/processed_data/SUP35_10seqs.clustalw
```
Generating the output in fasta format:
```bash
clustalw -INFILE=./data/raw_data/SUP35_10seqs.fa -OUTPUT=FASTA -OUTFILE=./data/processed_data/SUP35_10seqs.clustalw.fa
```
### muscle
```bash
muscle   -in ./data/raw_data/SUP35_10seqs.fa -out ./data/processed_data/SUP35_10seqs_muscle.fa
```
time:
```bash
real    0m4,742s
user    0m4,712s
sys     0m0,022s
```
### mafft
```bash
mafft --auto ./data/raw_data/SUP35_10seqs.fa >./data/raw_data/SUP35_10seqs_mafft.fa
```
time:
```bash
real    0m4,486s
user    0m4,351s
sys     0m0,156s
```
### kalign
```bash
kalign <./data/raw_data/SUP35_10seqs.fa >./data/processed_data/SUP35_10seqs_kalign.fa
```
time:
```bash
real    0m0,242s
user    0m0,357s
sys     0m0,008s
```
### t_coffee
```bash
t_coffee -infile=./data/raw_data/SUP35_10seqs.fa -outfile=./data/processed_data/SUP35_10seqs_tcoffee.fa
```
time:
```bash
real    1m31,287s
user    1m29,863s
sys     0m1,477s
```
### prank
```bash
prank -d=./data/raw_data/SUP35_10seqs.fa -o=./data/processed_data/SUP35_10seqs_prank.fa
```
time:
```bash
real    0m12,179s
user    0m12,006s
sys     0m0,163s
```
## 3. Comparation of the results on 10 DNA sequences
The table containing real times and grapical representation of the results can be found in Supplementary (Table 1, Figures 1-5)<br>
I find mafft and t-coffee the best ones
## 4. Reverse complement problem
While opening the file ./data/raw_data/SUP35_10seqs_strange_aln.fa we can see that alignment for 1 sequence is not satisfactory (Supplementary, fig. 6). But if we BLAST it, we see that it is the same gene of the same organism. The answer is to find the reverse complement sequence and realign it
## 5. Using 6 various alignment algorithms on 250 DNA sequences
### clustalw
```bash
clustalw -INFILE=./data/raw_data/SUP35_250seqs.fa OUTPUT=FASTA -OUTFILE=./data/processed_data/SUP35_250seqs.clustalw.fa
```
time:
```bash
real    29m3,728s
user    29m2,200s
sys     0m1,483s
```
### muscle
```bash
muscle -in ./data/raw_data/SUP35_250seqs.fa -out ./data/processed_data/SUP35_250seqs_muscle.fa
```
time
```bash
real    1m20,447s
user    1m20,169s
sys     0m0,276s
```
### mafft
```bash
mafft --auto ./data/raw_data/SUP35_250seqs.fa >./data/processed_data/SUP35_250seqs_mafft.fa
```
time:
```bash
real    0m39,807s
user    0m39,104s
sys     0m0,744s
```
### kalign
```bash
kalign <./data/raw_data/SUP35_250seqs.fa >./data/processed_data/SUP35_250seqs_kalign.fa
```
time:
```bash
real    0m3,912s
user    0m7,910s
sys     0m0,105s
```
### t_coffee
```bash
t_coffee -infile=./data/raw_data/SUP35_250seqs.fa -outfile=./data/processed_data/SUP35_250seqs_tcoffee.fa
```
I decided to interrupt the process after:
```bash
real    39m1,756s
user    0m0,761s
sys     0m0,275s
```
### prank
```bash
prank -d=./data/raw_data/SUP35_250seqs.fa -o=./data/processed_data/SUP35_250seqs_prank.fa
```
time:
```bash
real    2m39,690s
user    2m35,851s
sys     0m1,994s
```
## 6. Comparation of the results on 250 DNA sequences
The table containing real times and grapical representation of the results can be found in Supplementary (Table 1, Figures 7-10)<br>
I find CLUSTAL to be the best when you can wait or muscle when you want to make it faster.
## 7. Translation
Let's translate the 10 DNA sequences:<br>
```bash
transeq -sequence ./data/raw_data/SUP35_10seqs.fa -outseq ./data/processed_data/SUP35_10seqs.t.faa
```
Another way is to use getorf. getorf gives you the ORF and its coordinates in nucleotides. We shold give the minsize near the protein size (in nucleotides) to get its sequence witout other small peptides.
```bash
getorf -sequence ./data/raw_data/SUP35_10seqs.fa -outseq ./data/processed_data/SUP35_10seqs.g.faa -noreverse -minsize 500
```
## 8. Using 6 various alignment algorithms on 10 protein sequences
We use protein sequences of the same gene from the same organisms
### clustalw
```bash
clustalw -INFILE=./data/processed_data/SUP35_10seqs.g.faa -OUTFILE=./data/raw_data/SUP35_10seqs.clustalw.faa -OUTPUT=FASTA -TYPE=protein
```
time:
```bash
real    0m0,715s
user    0m0,715s
sys     0m0,000s
```
```bash
clustalo --infile=./data/processed_data/SUP35_10seqs.g.faa --outfile=./data/processed_data/SUP35_10seqs.clustalo.faa --verbose
```
time:
```bash
real    0m0,625s
user    0m1,072s
sys     0m0,109s
```
### muscle
```bash
muscle -in ./data/processed_data/SUP35_10seqs.g.faa -out ./data/processed_data/SUP35_10seqs_muscle.faa
```
time:
```bash
real    0m0,358s
user    0m0,342s
sys     0m0,016s
```
### mafft
```bash
mafft --auto ./data/processed_data/SUP35_10seqs.g.faa >./data/processed_data/SUP35_10seqs_mafft.faa
```
time:
```bash
real    0m0,618s
user    0m0,576s
sys     0m0,094s
```
### kalign
```bash
kalign <./data/processed_data/SUP35_10seqs.g.faa >./data/processed_data/SUP35_10seqs_kalign.faa
```
time:
```bash
real    0m0,076s
user    0m0,176s
sys     0m0,016s
```
### t_coffee
```bash
t_coffee -infile=./data/processed_data/SUP35_10seqs.g.faa -outfile=./data/processed_data/SUP35_10seqs_tcoffee.faa
```
time:
```bash
real    0m15,731s
user    0m15,329s
sys     0m0,402s
```
### prank
```bash
prank -d=./data/processed_data/SUP35_10seqs.g.faa -o=./data/processed_data/SUP35_10seqs_prank.faa
```
time:
```bash
real    0m12,729s
user    0m12,461s
sys     0m0,317s
```
## 9. Comparation of the results on 10 protein sequences
The table containing real times and grapical representation of the results can be found in Supplementary (Table 1, Figures 11-15)<br>
I think muscle is the best for this goal.
## 10. Add more alignments using muscle/mafft:
Here I align 2 more DNA sequences and add them to the files with 250 aligned DNA sequences using muscle of mafft.
```bash
muscle -in ./data/raw_data/SUP35_2addseqs.fa -out ./data/processed_data/SUP35_2addseqs_muscle.fa
muscle -profile -in1 ./data/processed_data/SUP35_250seqs_muscle.fa -in2 ./data/processed_data/SUP35_2addseqs_muscle.fa -out ./data/processed_data/SUP35_252seqs_muscle.fa
```
```bash
mafft --auto ./data/raw_data/SUP35_2addseqs.fa > ./data/processed_data/SUP35_2addseqs_mafft.fa
mafft --add ./data/processed_data/SUP35_2addseqs_mafft.fa ./data/processed_data/SUP35_250seqs_mafft.fa > ./data/processed_data/SUP35_252seqs_mafft.fa
```
